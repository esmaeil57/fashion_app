import 'package:fashion/features/favorites/domain/repositories/favorites_repository.dart';

class RemoveFavorite {
  final FavoritesRepository repository;

  RemoveFavorite(this.repository);

  Future<void> call(String productId) async {
    await repository.removeFavorite(productId);
  }
}