import 'dart:io';
import 'package:dio/io.dart';
import 'package:fashion/core/network/api/api_consumer.dart';
import 'package:fashion/core/network/api/status_code.dart';
import 'package:fashion/core/network/config/config_file.dart';
import 'package:fashion/core/network/error/exceptions.dart';
import 'package:fashion/core/network/error/network_error_handler.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'app_interceptor.dart';
import '../../dependency_injection/injector.dart' as di;

class DioConsumer implements ApiConsumer {
  final Dio client;
  DioConsumer({required this.client}) {
    (client.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    client.options
      ..baseUrl = Config.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(di.injector<AppInterceptor>());
    // client.interceptors.add(DioNetworkLogger());
    client.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) => {handler.next(e)},
    ));
    if (kDebugMode) {
      client.interceptors.add(di.injector<LogInterceptor>());
    }
  }

  @override
  Future<Either<NetworkException, dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters,
      bool? isRespoonseTypeHtml = false}) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      if (response.statusCode == StatusCode.success) {
        return right(handleResponseAsJson(response));
      } else {
        return left(getStatusCodeError(response.statusCode, response, null));
      }
    } on DioException catch (error) {
      return left(handleDioError(error));
    }
  }

  @override
  Future<Either<NetworkException, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        options: options,
      );

      if (response.statusCode == StatusCode.successCreated ||
          response.statusCode == StatusCode.success) {
        return right(handleResponseAsJson(response));
      } else {
        return left(getStatusCodeError(response.statusCode, response, null));
      }
    } on DioException catch (error) {
      return left(handleDioError(error));
    }
  }

  @override
  Future<Either<NetworkException, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await client.put(
        path,
        queryParameters: queryParameters,
        data: body,
        options: options,
      );
      if (response.statusCode == StatusCode.success) {
        return right(handleResponseAsJson(response));
      } else {
        return left(getStatusCodeError(response.statusCode, response, null));
      }
    } on DioException catch (error) {
      return left(handleDioError(error));
    }
  }

  @override
  Future<Either<NetworkException, dynamic>> delete(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await client.delete(path,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body,
          options: options);
      if (response.statusCode == StatusCode.successButNoContent ||
          response.statusCode == StatusCode.success) {
        return right(response);
      } else {
        return left(getStatusCodeError(response.statusCode, response, null));
      }
    } on DioException catch (error) {
      return left(handleDioError(error));
    }
  }

  @override
  Future<Either<NetworkException, dynamic>> getCarProducts(String path,
      {Map<String, dynamic>? queryParameters,
      bool? isRespoonseTypeHtml}) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      if (response.statusCode == StatusCode.success) {
        return right(response);
      } else {
        return left(getStatusCodeError(response.statusCode, response, null));
      }
    } on DioException catch (error) {
      return left(handleDioError(error));
    }
  }
}
