import 'package:fashion/features/favorites/domain/entities/favorite.dart';
import 'package:fashion/features/favorites/domain/repositories/favorites_repository.dart';

class GetFavorites {
  final FavoritesRepository repository;

  GetFavorites(this.repository);

  Future<List<Favorite>> call() async {
    return await repository.getFavorites();
  }
}