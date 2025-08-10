import 'package:fashion/features/favorites/domain/repositories/favorites_repository.dart';

class IsFavorite {
  final FavoritesRepository repository;

  IsFavorite(this.repository);

  Future<bool> call(String productId) async {
    return await repository.isFavorite(productId);
  }
}