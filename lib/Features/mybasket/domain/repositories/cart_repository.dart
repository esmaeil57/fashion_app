import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCartItems();
  Future<void> addToCart(CartItem item);
  Future<void> updateCartItem(CartItem item);
  Future<void> removeFromCart(String productId, String size, String color);
  Future<void> clearCart();
  Future<int> getCartItemsCount();
  Future<double> getCartTotal();
  Stream<List<CartItem>> watchCartItems();
}