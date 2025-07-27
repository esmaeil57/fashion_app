import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/features/mainpage/presentation/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/features/mainpage/presentation/widgets/bottom_nav_bar.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fashion International Group',
      home: BlocProvider(
        create: (context) => NavigationCubit(),
        child: MainPage(),
      ),
    );
  }
}
