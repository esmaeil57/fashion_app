import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/features/products/data/datasources/product_remote_data_source.dart';
import 'package:fashion/features/products/data/repositories/product_repository_impl.dart';
import 'package:fashion/features/products/domain/repo_interface/product_repository.dart';
import 'package:fashion/features/products/domain/usecase/get_products.dart';
import 'package:fashion/features/products/presentation/cubit/product_cubit.dart';

Future<void> productInjector() async {
  // Data sources
  injector.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(apiConsumer: injector()),
  );

  // Repository
  injector.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: injector(),
      networkInfo: injector(),
    ),
  );

  // Use cases
  injector.registerLazySingleton(() => GetProducts(injector()));
  injector.registerLazySingleton(() => GetAllProducts(injector()));
  injector.registerLazySingleton(() => SearchProducts(injector()));

  // Cubit
  injector.registerFactory(
    () => ProductCubit(
      getProducts: injector(),
      getAllProducts: injector(),
    ),
  );
}