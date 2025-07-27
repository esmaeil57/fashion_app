import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/core/network/api/api_consumer.dart';
import 'package:fashion/core/network/network_info.dart';
import '../data/repositories/category_repository_impl.dart';
import '../domain/repo_interface/category_repository.dart';
import '../domain/usecase/get_categories.dart';
import '../presentation/cubit/category_cubit.dart';

Future<void> allCategoriesInjector() async {
  // Register repository
  injector.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      apiConsumer: injector<ApiConsumer>(),
      networkInfo: injector<NetworkInfo>(),
    ),
  );

  // Register use case
  injector.registerLazySingleton<GetCategories>(
    () => GetCategories(injector<CategoryRepository>()),
  );

  // Register cubit
  injector.registerFactory<CategoryCubit>(
    () => CategoryCubit(getCategories: injector<GetCategories>()),
  );
}