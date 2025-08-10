import 'package:fashion/features/favorites/data/models/favorite_model.dart';
import 'package:hive/hive.dart';

abstract class FavoritesLocalDataSource {
  Future<List<FavoriteModel>> getFavorites();
  Future<void> addFavorite(FavoriteModel favorite);
  Future<void> removeFavorite(String productId);
  Future<bool> isFavorite(String productId);
  Future<void> clearFavorites();
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static const String _boxName = 'favorites';
  late Box<FavoriteModel> _favoritesBox;

  FavoritesLocalDataSourceImpl() {
    _initBox();
  }

  Future<void> _initBox() async {
    _favoritesBox = await Hive.openBox<FavoriteModel>(_boxName);
  }

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    await _ensureBoxOpen();
    return _favoritesBox.values.toList()
      ..sort((a, b) => b.addedAt.compareTo(a.addedAt)); // Sort by newest first
  }

  @override
  Future<void> addFavorite(FavoriteModel favorite) async {
    await _ensureBoxOpen();
    await _favoritesBox.put(favorite.productId, favorite);
  }

  @override
  Future<void> removeFavorite(String productId) async {
    await _ensureBoxOpen();
    await _favoritesBox.delete(productId);
  }

  @override
  Future<bool> isFavorite(String productId) async {
    await _ensureBoxOpen();
    return _favoritesBox.containsKey(productId);
  }

  @override
  Future<void> clearFavorites() async {
    await _ensureBoxOpen();
    await _favoritesBox.clear();
  }

  Future<void> _ensureBoxOpen() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _favoritesBox = await Hive.openBox<FavoriteModel>(_boxName);
    }
  }
}