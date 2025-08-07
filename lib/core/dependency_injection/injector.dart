//import 'package:fashion/core/datasource/remote/cart/di/cart_injector.dart';
//import 'package:fashion/core/local_storage/di/local_storage_injector.dart';
import 'package:fashion/core/network/api/dio_injector.dart';
//import 'package:fashion/features/Home/di/all_categories_injector.dart';
//import 'package:fashion/features/products_per_category/di/products_per_category_injector.dart';
//import 'package:fashion/features/product_details/di/product_details_injector.dart';
//import 'package:fashion/features/profile/di/profile_injector.dart';
//import 'package:fashion/features/search/di/search_injector.dart';
import 'package:fashion/features/categories/di/all_categories_injector.dart';
import 'package:fashion/features/homepage/di/home_page_injector.dart';
import 'package:fashion/features/products/di/product_injector.dart';
//import 'package:fashion/features/favourites/di/favourite_injector.dart';
import 'package:get_it/get_it.dart';
//import '../bloc_observer/bloc_observer_injector.dart';

final injector = GetIt.instance;

Future<void> initInjection() async {
  // await blocObserverInjector();
  await dioInjector();

  //await hiveInjector();

  //await cartInjector();

  //await allCategoryInHomeInjector();

  //await productsPerCategoryInjector();

  //await productDetailsInjector();

  //await profileInjector();

  // await searchInjector();
  await allCategoriesInjector();
  await productInjector();
  await homepageInjector();


  //await favouriteInjector();
  // await paymentGetwayInjector();
}