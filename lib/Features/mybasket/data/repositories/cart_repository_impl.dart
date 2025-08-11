import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_datasource.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<List<CartItem>> getCartItems() async {
    try {
      final cartModels = await localDataSource.getCartItems();
      return cartModels.cast<CartItem>();
    } catch (e) {
      throw Exception('Failed to get cart items: $e');
    }
  }

  @override
  Future<void> addToCart(CartItem item) async {
    try {
      final cartModel = CartItemModel.fromEntity(item);
      await localDataSource.addToCart(cartModel);
    } catch (e) {
      throw Exception('Failed to add item to cart: $e');
    }
  }

  @override
  Future<void> updateCartItem(CartItem item) async {
    try {
      final cartModel = CartItemModel.fromEntity(item);
      await localDataSource.updateCartItem(cartModel);
    } catch (e) {
      throw Exception('Failed to update cart item: $e');
    }
  }

  @override
  Future<void> removeFromCart(String productId, String size, String color) async {
    try {
      await localDataSource.removeFromCart(productId, size, color);
    } catch (e) {
      throw Exception('Failed to remove item from cart: $e');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await localDataSource.clearCart();
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  @override
  Future<int> getCartItemsCount() async {
    try {
      final items = await getCartItems();
      return items.fold<int>(0, (total, item) => total + item.quantity);
    } catch (e) {
      throw Exception('Failed to get cart items count: $e');
    }
  }

  @override
  Future<double> getCartTotal() async {
    try {
      final items = await getCartItems();
      return items.fold<double>(0.0, (total, item) => total + item.totalPrice);
    } catch (e) {
      throw Exception('Failed to get cart total: $e');
    }
  }

  @override
  Stream<List<CartItem>> watchCartItems() {
    try {
      return localDataSource.watchCartItems().map((models) => models.cast<CartItem>());
    } catch (e) {
      throw Exception('Failed to watch cart items: $e');
    }
  }
}