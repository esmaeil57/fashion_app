import 'package:fashion/core/network/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
// import 'package:flutter_wp_woocommerce/woocommerce.dart';

abstract class ApiConsumer {
  // WooCommerce wooCommerceFuns();

  Future<Either<NetworkException, dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters, bool? isRespoonseTypeHtml});

  Future<Either<NetworkException, dynamic>> getCarProducts(String path,
      {Map<String, dynamic>? queryParameters, bool? isRespoonseTypeHtml});

  Future<Either<NetworkException, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool formDataIsEnabled,
  });

  Future<Either<NetworkException, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool formDataIsEnabled,
  });

  Future<Either<NetworkException, dynamic>> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool formDataIsEnabled,
  });
}
