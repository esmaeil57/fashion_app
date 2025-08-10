import 'package:fashion/features/favorites/domain/entities/favorite.dart';
import 'package:fashion/features/favorites/domain/usecases/add_favorite.dart';
import 'package:fashion/features/favorites/domain/usecases/clear_favorites.dart';
import 'package:fashion/features/favorites/domain/usecases/get_favorites.dart';
import 'package:fashion/features/favorites/domain/usecases/is_favorite.dart';
import 'package:fashion/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:fashion/features/favorites/presentation/cubit/favorite_state.dart';
import 'package:fashion/features/products/domain/entities/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavorites getFavorites;
  final AddFavorite addFavorite;
  final RemoveFavorite removeFavorite;
  final IsFavorite isFavorite;
  final ClearFavorites clearFavorites;

  FavoritesCubit({
    required this.getFavorites,
    required this.addFavorite,
    required this.removeFavorite,
    required this.isFavorite,
    required this.clearFavorites,
  }) : super(FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    try {
      final favorites = await getFavorites();
      final favoriteProductIds = favorites.map((f) => f.productId).toSet();
      
      emit(FavoritesLoaded(
        favorites: favorites,
        favoriteProductIds: favoriteProductIds,
      ));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(Product product) async {
    try {
      final isCurrentlyFavorite = await isFavorite(product.id);
      
      if (isCurrentlyFavorite) {
        await removeFavorite(product.id);
        emit(FavoriteToggleSuccess(
          isAdded: false,
          productName: product.name,
        ));
      } else {
        final favorite = Favorite.fromProduct(
          productId: product.id,
          productName: product.name,
          productImage: product.imageUrls.isNotEmpty ? product.imageUrls.first : '',
          productPrice: product.price,
          salePrice: product.salePrice,
          isOnSale: product.isOnSale,
          categoryName: product.categoryName,
        );
        await addFavorite(favorite);
        emit(FavoriteToggleSuccess(
          isAdded: true,
          productName: product.name,
        ));
      }
      
      // Reload favorites to update the list
      await loadFavorites();
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> removeFavoriteById(String productId) async {
    try {
      await removeFavorite(productId);
      await loadFavorites();
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> clearAllFavorites() async {
    try {
      await clearFavorites();
      emit(const FavoritesLoaded(
        favorites: [],
        favoriteProductIds: {},
      ));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<bool> checkIsFavorite(String productId) async {
    try {
      return await isFavorite(productId);
    } catch (e) {
      return false;
    }
  }
}