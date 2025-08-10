import 'package:fashion/features/favorites/domain/entities/favorite.dart';

abstract class FavoritesRepository {
  Future<List<Favorite>> getFavorites();
  Future<void> addFavorite(Favorite favorite);
  Future<void> removeFavorite(String productId);
  Future<bool> isFavorite(String productId);
  Future<void> clearFavorites();
}