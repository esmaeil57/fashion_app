import 'package:fashion/features/favorites/domain/entities/favorite.dart';

abstract class FavoritesState {
  const FavoritesState();
  
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Favorite> favorites;
  final Set<String> favoriteProductIds;

  const FavoritesLoaded({
    required this.favorites,
    required this.favoriteProductIds,
  });

  @override
  List<Object> get props => [favorites, favoriteProductIds];

  FavoritesLoaded copyWith({
    List<Favorite>? favorites,
    Set<String>? favoriteProductIds,
  }) {
    return FavoritesLoaded(
      favorites: favorites ?? this.favorites,
      favoriteProductIds: favoriteProductIds ?? this.favoriteProductIds,
    );
  }
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteToggleSuccess extends FavoritesState {
  final bool isAdded;
  final String productName;

  const FavoriteToggleSuccess({
    required this.isAdded,
    required this.productName,
  });

  @override
  List<Object> get props => [isAdded, productName];
}