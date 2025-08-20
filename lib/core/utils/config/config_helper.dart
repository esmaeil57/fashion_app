import 'package:flutter/services.dart';

class ConfigHelper {
  static const MethodChannel _channel = MethodChannel("com.example.fashion/config");

  static Future<String> getMapsApiKey() async {
    final apiKey = await _channel.invokeMethod<String>("getMapsApiKey");
    return apiKey ?? "";
  }
}
