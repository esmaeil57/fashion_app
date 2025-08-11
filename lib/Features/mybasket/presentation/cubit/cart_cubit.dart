import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/clear_cart.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/remove_from_cart.dart';
import '../../domain/usecases/update_cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItems getCartItems;
  final AddToCart addToCart;
  final UpdateCartItem updateCartItem;
  final RemoveFromCart removeFromCart;
  final ClearCart clearCart;

  CartCubit({
    required this.getCartItems,
    required this.addToCart,
    required this.updateCartItem,
    required this.removeFromCart,
    required this.clearCart,
  }) : super(const CartInitial());

  Future<void> loadCart() async {
    try {
      emit(const CartLoading());
      final items = await getCartItems();
      _emitCartLoaded(items);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addItemToCart({
    required String productId,
    required String productName,
    required String imageUrl,
    required double price,
    double? salePrice,
    required String selectedSize,
    required String selectedColor,
    required String categoryName,
    required List<String> availableSizes,
    required List<String> availableColors,
    required bool isOnSale,
    int quantity = 1,
  }) async {
    try {
      final cartItem = CartItem(
        productId: productId,
        productName: productName,
        imageUrl: imageUrl,
        price: price,
        salePrice: salePrice,
        selectedSize: selectedSize,
        selectedColor: selectedColor,
        quantity: quantity,
        addedAt: DateTime.now(),
        categoryName: categoryName,
        availableSizes: availableSizes,
        availableColors: availableColors,
        isOnSale: isOnSale,
      );

      await addToCart(cartItem);

      // Emit success state first
      emit(CartItemAdded(productName: productName, quantity: quantity));

      // Then reload cart
      final items = await getCartItems();
      _emitCartLoaded(items);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> updateItemQuantity(CartItem item, int newQuantity) async {
    try {
      if (newQuantity <= 0) {
        await removeItemFromCart(
          item.productId,
          item.selectedSize,
          item.selectedColor,
        );
        return;
      }

      final updatedItem = item.copyWith(quantity: newQuantity);
      await updateCartItem(updatedItem);

      emit(
        CartItemUpdated(
          productName: item.productName,
          newQuantity: newQuantity,
        ),
      );

      final items = await getCartItems();
      _emitCartLoaded(items);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> removeItemFromCart(
    String productId,
    String size,
    String color,
  ) async {
    try {
      // Get item name before removing for the success message
      final currentItems = await getCartItems();
      final itemToRemove = currentItems.firstWhere(
        (item) =>
            item.productId == productId &&
            item.selectedSize == size &&
            item.selectedColor == color,
      );

      await removeFromCart(productId, size, color);

      emit(CartItemRemoved(productName: itemToRemove.productName));

      final items = await getCartItems();
      _emitCartLoaded(items);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> clearAllItems() async {
    try {
      await clearCart();
      _emitCartLoaded([]);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void _emitCartLoaded(List<CartItem> items) {
    final subtotal = items.fold<double>(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );
    final shipping =
        subtotal > 0 ? 50.0 : 0.0; // Free shipping above certain amount
    final taxRate = 0.14; // 14% tax rate similar to the image
    final tax = subtotal * taxRate;
    final discountRate =
        subtotal > 3000 ? 0.05 : 0.0; // 5% discount for orders above 3000 EGP
    final discount = subtotal * discountRate;
    final total = subtotal + shipping + tax - discount;
    final totalItems = items.fold<int>(0, (sum, item) => sum + item.quantity);

    emit(
      CartLoaded(
        items: items,
        subtotal: subtotal,
        shipping: shipping,
        tax: tax,
        discount: discount,
        total: total,
        totalItems: totalItems,
      ),
    );
  }

  Future<bool> isItemInCart(String productId, String size, String color) async {
    try {
      final items = await getCartItems();
      return items.any(
        (item) =>
            item.productId == productId &&
            item.selectedSize == size &&
            item.selectedColor == color,
      );
    } catch (e) {
      return false;
    }
  }

  Future<int> getCartItemsCount() async {
    try {
      final items = await getCartItems();
      return items.fold<int>(0, (sum, item) => sum + item.quantity);
    } catch (e) {
      return 0;
    }
  }
}