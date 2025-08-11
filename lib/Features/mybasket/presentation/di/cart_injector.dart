import 'package:fashion/features/mybasket/data/datasources/cart_local_datasource.dart';
import 'package:fashion/features/mybasket/data/models/cart_item_model.dart';
import 'package:fashion/features/mybasket/data/repositories/cart_repository_impl.dart';
import 'package:fashion/features/mybasket/domain/repositories/cart_repository.dart';
import 'package:fashion/features/mybasket/domain/usecases/add_to_cart.dart';
import 'package:fashion/features/mybasket/domain/usecases/clear_cart.dart';
import 'package:fashion/features/mybasket/domain/usecases/get_cart_items.dart';
import 'package:fashion/features/mybasket/domain/usecases/remove_from_cart.dart';
import 'package:fashion/features/mybasket/domain/usecases/update_cart_item.dart';
import 'package:fashion/features/mybasket/presentation/cubit/cart_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final injector = GetIt.instance;

Future<void> cartInjector() async {
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive adapters
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(CartItemModelAdapter());
  }

  // Data sources
  injector.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(),
  );

  // Repository
  injector.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDataSource: injector()),
  );

  // Use cases
  injector.registerLazySingleton(() => GetCartItems(injector()));
  injector.registerLazySingleton(() => AddToCart(injector()));
  injector.registerLazySingleton(() => UpdateCartItem(injector()));
  injector.registerLazySingleton(() => RemoveFromCart(injector()));
  injector.registerLazySingleton(() => ClearCart(injector()));

  // Cubit
  injector.registerFactory(
    () => CartCubit(
      getCartItems: injector(),
      addToCart: injector(),
      updateCartItem: injector(),
      removeFromCart: injector(),
      clearCart: injector(),
    ),
  );
}