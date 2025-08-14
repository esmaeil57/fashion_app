import 'dart:developer' as developer;
import 'package:easy_localization/easy_localization.dart';
// import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';

enum LanguagesEnum { ar, en }

class AppLocalization {
  /// Convert languagesEnum To Locale
  Locale languagesEnumToLocale(LanguagesEnum language) {
    return Locale(language.toString().split('.').last);
  }

  Locale getCurrentLocale(BuildContext context) {
    return context.locale;
  }

  static String getCurrentLangCode(BuildContext context) {
    developer.log(context.locale.toString(), name: 'Lang cont');
    return context.locale.toString();
  }

  /// Set language using locale
  void setLocale(BuildContext context, Locale selectedLanguage) {
    context.setLocale(selectedLanguage);
  }

  /// Set language using languagesEnum
  void setLanguage(BuildContext context, LanguagesEnum selectedLanguage) {
    context.setLocale(languagesEnumToLocale(selectedLanguage));
  }

  /// This method will be called from every widget which needs a localized text
  static String translate(String key) {
    return key.tr();
  }

  /// This method will be called from every widget which needs a localized number
  /// to keep the number the same format
  static String translateNumber(
      {required BuildContext context, required String number}) {
    return isRTL(context) ? number.split('').reversed.join() : number;
  }

  /// Returns true in case the language is Right to Left
  static bool isRTL(BuildContext context) {
    //return context.locale.languageCode == 'ar';
    return Directionality.of(context).toString().toLowerCase().contains('rtl');
  }

  ///Setup localization at the start of the app
  EasyLocalization appLocalizationSetup({
    required Widget app,
    required String path,
    required Locale startLocale,
    required List<Locale> supportedLocalesList,
  }) {
    return EasyLocalization(
      supportedLocales: supportedLocalesList,
      path: path,

//add this line when we use localization from the server
      // assetLoader: const HttpAssetLoader(),
      // fallbackLocale: const Locale('en'),
      startLocale: startLocale,
      child: app,
    );
  }
}
