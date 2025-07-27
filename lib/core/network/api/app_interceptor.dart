import 'dart:convert';
import 'package:fashion/core/network/config/config_file.dart';
import 'package:dio/dio.dart';
import '../../utils/app_strings/dio_strings.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var authToken =
        base64.encode(utf8.encode(Config.key + ":" + Config.secret));
    print(authToken);
    options.headers[DioStrings.authorization] = "Basic $authToken";
    options.headers[DioStrings.contentType] = "application/json";

    super.onRequest(options, handler);
  }
}
