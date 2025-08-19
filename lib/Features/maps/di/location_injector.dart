import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/features/maps/data/datasources/location_data_source.dart';
import 'package:fashion/features/maps/data/repositories/location_repository_impl.dart';
import 'package:fashion/features/maps/domain/repositories/location_repository.dart';
import 'package:fashion/features/maps/domain/usecases/check_location_permission.dart';
import 'package:fashion/features/maps/domain/usecases/get_current_location.dart';
import 'package:fashion/features/maps/domain/usecases/get_distance.dart';
import 'package:fashion/features/maps/domain/usecases/get_location_stream.dart';
import 'package:fashion/features/maps/domain/usecases/get_route.dart';
import 'package:fashion/features/maps/domain/usecases/request_location_permission.dart';
import 'package:fashion/features/maps/presentation/cubit/location_cubit.dart';



Future<void> locationInjector() async {
  // Data Sources
  injector.registerLazySingleton<LocationDataSource>(() => LocationDataSourceImpl());
  
  // Repositories
  injector.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(dataSource: injector()),
  );
  
  // Use Cases
  injector.registerLazySingleton(() => CheckLocationPermission(injector()));
  injector.registerLazySingleton(() => GetCurrentLocation(injector()));
  injector.registerLazySingleton(() => GetLocationStream(injector()));
  injector.registerLazySingleton(() => RequestLocationPermission(injector()));
  injector.registerLazySingleton(() => GetRoute(injector()));
  injector.registerLazySingleton(() => GetDistance(injector()));
  
  // Cubit
  injector.registerFactory(
    () => LocationCubit(
      getCurrentLocation: injector(),
      requestLocationPermission: injector(),
      checkLocationPermission: injector(),
      getLocationStream: injector(),
      getRoute: injector(),
      getDistance: injector(),
    ),
  );
}