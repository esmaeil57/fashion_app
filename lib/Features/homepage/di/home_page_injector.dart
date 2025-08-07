
import 'package:fashion/core/dependency_injection/injector.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/repo_interface/product_repository.dart';
import '../domain/usecase/get_categories_usecase.dart';
import '../presentation/cubit/home_cubit.dart';

Future<void> homepageInjector() async {
  // Repository
  injector.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(apiConsumer: injector()),
  );

  // Use Case
  injector.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(injector<ProductRepository>()),
  );

  // Cubit
  injector.registerFactory<HomeCubit>(
    () => HomeCubit(injector<GetCategoriesUseCase>()),
  );
}