import 'dart:async';
import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/core/utils/location/location_permission_helper.dart';
import 'package:fashion/features/favorites/data/models/favorite_model.dart';
import 'package:fashion/features/mybasket/data/models/cart_item_model.dart';
import 'package:fashion/core/utils/locale/locale_helper.dart';
import 'package:fashion/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:easy_localization/easy_localization.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  // Register Hive adapters
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(FavoriteModelAdapter());
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(CartItemModelAdapter());
  }

  await LocationPermissionHelper.requestLocationPermission();
  final savedLocale = await LocaleHelper.getSavedLocale();
  await initInjection();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: savedLocale ?? const Locale('en'),
      child: const MyApp(flavor: 'staging'),
    ),
  );
}
