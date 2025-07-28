import 'package:fashion/core/network/error/request_error.dart';
import 'package:dio/dio.dart';

class NetworkException implements Exception {
  String? code;
  String? message;
  Data? data;
  DioException? dioError;
  Response<dynamic>? response;

  NetworkException([
    this.code,
    this.message,
    this.data,
    this.dioError,
    this.response,
  ]);

  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }

  NetworkException.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class FetchDataException extends NetworkException {
  FetchDataException({DioException? dioError, Response<dynamic>? response})
      : super("Error During Communication", null, null, dioError, response);
}

class BadRequestException extends NetworkException {
  RequestError requestError;

  BadRequestException(
      {required this.requestError,
      DioException? dioError,
      Response<dynamic>? response})
      : super.fromJson(requestError.toJson()) {
    this.dioError = dioError;
    this.response = response;
  }
}

class UnauthorizedException extends NetworkException {
  RequestError requestError;

  UnauthorizedException(
      {required this.requestError,
      DioException? dioError,
      Response<dynamic>? response})
      : super.fromJson(requestError.toJson()) {
    this.dioError = dioError;
    this.response = response;
  }
}

class NotFoundException extends NetworkException {
  RequestError requestError;

  NotFoundException(
      {required this.requestError,
      DioException? dioError,
      Response<dynamic>? response})
      : super.fromJson(requestError.toJson()) {
    this.dioError = dioError;
    this.response = response;
  }
}

class ConflictException extends NetworkException {
  ConflictException({DioException? dioError, Response<dynamic>? response})
      : super("Conflict Occurred", null, null, dioError, response);
}

class UnknownException extends NetworkException {
  UnknownException({DioException? dioError, Response<dynamic>? response})
      : super("Something went wrong", null, null, dioError, response);
}

class InternalServerErrorException extends NetworkException {
  InternalServerErrorException(
      {DioException? dioError, Response<dynamic>? response})
      : super("Internal Server Error", null, null, dioError, response);
}

class NoInternetConnectionException extends NetworkException {
  NoInternetConnectionException(
      {DioException? dioError, Response<dynamic>? response})
      : super("No Internet Connection", null, null, dioError, response);
}

class CacheException implements Exception {}

class CustomException implements Exception {
  final String? errorMassage;

  const CustomException([this.errorMassage]);
}
