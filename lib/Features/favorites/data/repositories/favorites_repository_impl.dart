import 'package:fashion/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:fashion/features/favorites/data/models/favorite_model.dart';
import 'package:fashion/features/favorites/domain/entities/favorite.dart';
import 'package:fashion/features/favorites/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Favorite>> getFavorites() async {
    try {
      final favoriteModels = await localDataSource.getFavorites();
      return favoriteModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get favorites: $e');
    }
  }

  @override
  Future<void> addFavorite(Favorite favorite) async {
    try {
      final favoriteModel = FavoriteModel.fromEntity(favorite);
      await localDataSource.addFavorite(favoriteModel);
    } catch (e) {
      throw Exception('Failed to add favorite: $e');
    }
  }

  @override
  Future<void> removeFavorite(String productId) async {
    try {
      await localDataSource.removeFavorite(productId);
    } catch (e) {
      throw Exception('Failed to remove favorite: $e');
    }
  }

  @override
  Future<bool> isFavorite(String productId) async {
    try {
      return await localDataSource.isFavorite(productId);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearFavorites() async {
    try {
      await localDataSource.clearFavorites();
    } catch (e) {
      throw Exception('Failed to clear favorites: $e');
    }
  }
}