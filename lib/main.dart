import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/features/favorites/data/models/favorite_model.dart';
import 'package:fashion/features/mainpage/presentation/cubit/navigation_cubit.dart';
import 'package:fashion/features/mybasket/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/features/mainpage/presentation/widgets/bottom_nav_bar.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   // Initialize Hive
  await Hive.initFlutter();
  // Register Hive adapters for favorites
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(FavoriteModelAdapter());
  }
   // Register Hive adapters for Cart
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(CartItemModelAdapter());
  }
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
