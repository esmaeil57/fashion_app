import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LocaleHelper {
  static const String _localeKey = 'selected_locale';

  static Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  static Future<Locale?> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_localeKey);
    if (code == null) return null;
    return Locale(code);
  }
}
