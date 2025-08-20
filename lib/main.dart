import 'dart:async';
import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/core/utils/location/location_permission_helper.dart';
import 'package:fashion/features/favorites/data/models/favorite_model.dart';
import 'package:fashion/features/mainpage/presentation/cubit/navigation_cubit.dart';
import 'package:fashion/features/mybasket/data/models/cart_item_model.dart';
import 'package:fashion/core/utils/locale/locale_helper.dart';
import 'package:fashion/core/observer/sentry_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/features/mainpage/presentation/widgets/bottom_nav_bar.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  SentryWidgetsFlutterBinding.ensureInitialized();
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

  Bloc.observer = SentryCubitObserver();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://aac62771c1bcfd7220abbe4fe98c4e29@o4509864569274368.ingest.us.sentry.io/4509864578121728';
      options.tracesSampleRate = 1.0;
      options.debug = true;
    },
    appRunner:
        () => runApp(
          EasyLocalization(
            supportedLocales: const [Locale('en'), Locale('ar')],
            path: 'assets/translations',
            fallbackLocale: const Locale('en'),
            startLocale: savedLocale ?? const Locale('en'),
            child: const MyApp(),
          ),
        ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fashion International Group',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      navigatorObservers: [SentryNavigatorObserver()],
      home: BlocProvider(
        create: (context) => NavigationCubit(),
        child: MainPage(),
      ),
    );
  }
}
