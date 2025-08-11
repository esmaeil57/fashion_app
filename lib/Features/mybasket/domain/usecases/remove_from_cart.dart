import '../repositories/cart_repository.dart';

class RemoveFromCart {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  Future<void> call(String productId, String size, String color) async {
    return await repository.removeFromCart(productId, size, color);
  }
}