import 'package:fashion/features/favorites/domain/repositories/favorites_repository.dart';

class ClearFavorites {
  final FavoritesRepository repository;

  ClearFavorites(this.repository);

  Future<void> call() async {
    await repository.clearFavorites();
  }
}