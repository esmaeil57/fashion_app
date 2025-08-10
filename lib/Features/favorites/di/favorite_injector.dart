import 'package:fashion/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:fashion/features/favorites/data/models/favorite_model.dart';
import 'package:fashion/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:fashion/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:fashion/features/favorites/domain/usecases/add_favorite.dart';
import 'package:fashion/features/favorites/domain/usecases/clear_favorites.dart';
import 'package:fashion/features/favorites/domain/usecases/get_favorites.dart';
import 'package:fashion/features/favorites/domain/usecases/is_favorite.dart';
import 'package:fashion/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:fashion/features/favorites/presentation/cubit/favorite_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

final injector = GetIt.instance;

Future<void> favoriteInjector() async {

  // Initialize Hive and register adapters
  await Hive.initFlutter();

   // Register Hive adapter for FavoriteModel
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(FavoriteModelAdapter());
  }

  // Favorites - Data Sources
  injector.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(),
  );

  // Favorites - Repository
  injector.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(
      localDataSource: injector<FavoritesLocalDataSource>(),
    ),
  );

  // Favorites - Use Cases
  injector.registerLazySingleton(() => GetFavorites(injector<FavoritesRepository>()));
  injector.registerLazySingleton(() => AddFavorite(injector<FavoritesRepository>()));
  injector.registerLazySingleton(() => RemoveFavorite(injector<FavoritesRepository>()));
  injector.registerLazySingleton(() => IsFavorite(injector<FavoritesRepository>()));
  injector.registerLazySingleton(() => ClearFavorites(injector<FavoritesRepository>()));

  // Favorites - Cubit
  injector.registerFactory(() => FavoritesCubit(
    getFavorites: injector<GetFavorites>(),
    addFavorite: injector<AddFavorite>(),
    removeFavorite: injector<RemoveFavorite>(),
    isFavorite: injector<IsFavorite>(),
    clearFavorites: injector<ClearFavorites>(),
  ));
}