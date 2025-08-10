import 'package:fashion/features/favorites/domain/entities/favorite.dart';
import 'package:fashion/features/favorites/domain/repositories/favorites_repository.dart';

class AddFavorite {
  final FavoritesRepository repository;

  AddFavorite(this.repository);

  Future<void> call(Favorite favorite) async {
    await repository.addFavorite(favorite);
  }
}