import 'dart:convert';
import 'package:fashion/core/network/api/status_code.dart';
import 'package:fashion/core/network/error/request_error.dart';
import 'package:dio/dio.dart';
import 'exceptions.dart';

dynamic handleResponseAsJson(Response<dynamic> response) {
  final responseJson = jsonDecode(response.data.toString());

  return responseJson;
}

NetworkException handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return FetchDataException(dioError: error, response: error.response);
    case DioExceptionType.badResponse:
      if (error.response?.data != null) {
        try {
          final responseData = error.response?.data;
          if (responseData is Map) {
            final exception = NetworkException.fromJson(
                Map<String, dynamic>.from(responseData));
            exception.dioError = error;
            exception.response = error.response;
            return exception;
          } else if (responseData is String) {
            final jsonData = json.decode(responseData);
            final exception =
                NetworkException.fromJson(Map<String, dynamic>.from(jsonData));
            exception.dioError = error;
            exception.response = error.response;
            return exception;
          }
        } catch (e) {
          print('Error parsing error response: $e');
        }
      }
      return getStatusCodeError(
          error.response?.statusCode, error.response, error);
    case DioExceptionType.unknown:
      return NoInternetConnectionException(
          dioError: error, response: error.response);
    default:
      return UnknownException(dioError: error, response: error.response);
  }
}

NetworkException getStatusCodeError(
  int? statusCode,
  Response<dynamic>? response,
  DioException? error,
) {
  if (response?.data != null) {
    try {
      final responseData = response?.data;
      if (responseData is Map) {
        final exception =
            NetworkException.fromJson(Map<String, dynamic>.from(responseData));
        exception.dioError = error;
        exception.response = response;
        return exception;
      } else if (responseData is String) {
        final jsonData = json.decode(responseData);
        final exception =
            NetworkException.fromJson(Map<String, dynamic>.from(jsonData));
        exception.dioError = error;
        exception.response = response;
        return exception;
      }
    } catch (e) {
      print('Error parsing error response: $e');
    }
  }

  switch (statusCode) {
    case StatusCode.badRequest:
      return BadRequestException(requestError: parseRequestError(response));
    case StatusCode.unauthorized:
      return UnauthorizedException(requestError: parseRequestError(response));
    case StatusCode.forbidden:
      return UnauthorizedException(requestError: parseRequestError(response));
    case StatusCode.notFound:
      return parseRequestError(response).code == null
          ? UnknownException(dioError: error, response: response)
          : NotFoundException(requestError: parseRequestError(response));
    case StatusCode.conflict:
      return ConflictException(dioError: error, response: response);
    case StatusCode.internalServerError:
      return InternalServerErrorException(dioError: error, response: response);
    default:
      return UnknownException(dioError: error, response: response);
  }
}

RequestError parseRequestError(Response<dynamic>? response) {
  if (response?.data == null) {
    return RequestError();
  }

  try {
    // If data is already a Map, use it directly
    if (response?.data is Map) {
      return RequestError.fromJson(response?.data);
    }

    // If data is a String, try to parse it
    if (response?.data is String) {
      final responseBody = json.decode(response?.data);
      return RequestError.fromJson(responseBody);
    }

    return RequestError();
  } catch (e) {
    print('Error parsing response: $e');
    return RequestError();
  }
}
