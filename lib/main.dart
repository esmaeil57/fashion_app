import 'package:easy_localization/easy_localization.dart';
import 'package:fashion/features/mainpage/presentation/cubit/navigation_cubit.dart';
import 'package:fashion/features/mainpage/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required String flavor});

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
