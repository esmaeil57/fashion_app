import '../../../core/dependency_injection/injector.dart';
import '../domain/usecases/search_products_usecase.dart';
import '../presentation/cubit/search_cubit.dart';

Future<void> searchInjector() async {
  // Use case
  injector.registerLazySingleton(
    () => SearchProductsUsecase(productRepository: injector()),
  );

  // Cubit
  injector.registerFactory(
    () => SearchCubit(searchProductsUsecase: injector()),
  );
}