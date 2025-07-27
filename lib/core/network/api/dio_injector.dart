import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/core/network/api/api_consumer.dart';
import 'package:fashion/core/network/network_info.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'app_interceptor.dart';
import 'dio_consumer.dart';

Future<void> dioInjector() async {
  injector.registerLazySingleton(() => AppInterceptor());

  injector.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
  injector.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  injector.registerLazySingleton(() => Dio());
  injector.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: injector()));
  injector.registerLazySingleton<ApiConsumer>(
      () => DioConsumer(client: injector()));
}
