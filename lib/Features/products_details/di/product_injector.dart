import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/features/products_details/data/datasources/product_remote_data_source.dart';
import 'package:fashion/features/products_details/data/repositories/product_repository_impl.dart';
import 'package:fashion/features/products_details/domain/repo_interface/product_repository.dart';
import 'package:fashion/features/products_details/domain/usecase/get_product_details.dart';
import 'package:fashion/features/products_details/presentation/cubit/product_details_cubit.dart';

Future<void> productDetailsInjector() async {
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
  injector.registerLazySingleton(() => GetProductDetails(injector()));

  // Cubit
  injector.registerFactory(
    () => ProductDetailsCubit(getProductDetails: injector(),),
  );
}
