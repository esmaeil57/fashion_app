import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/features/favorites/data/models/favorite_model.dart';
import 'package:fashion/features/mainpage/presentation/cubit/navigation_cubit.dart';
import 'package:fashion/features/mybasket/data/models/cart_item_model.dart';
import 'package:fashion/core/utils/locale/locale_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/features/mainpage/presentation/widgets/bottom_nav_bar.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();
  // Initialize Hive
  await Hive.initFlutter();
  // Register Hive adapters for favorites
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(FavoriteModelAdapter());
  }
  // Register Hive adapters for Cart
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(CartItemModelAdapter());
  }
  await initInjection();
  // Get saved locale or default to English
  final savedLocale = await LocaleHelper.getSavedLocale();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: savedLocale ?? const Locale('en'),
      child: const MyApp(),
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

      // Localization delegates
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      home: BlocProvider(
        create: (context) => NavigationCubit(),
        child: MainPage(),
      ),
    );
  }
}
