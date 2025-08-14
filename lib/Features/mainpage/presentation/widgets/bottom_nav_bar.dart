import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/features/categories/domain/usecase/get_categories.dart';
import 'package:fashion/features/categories/presentation/cubit/category_cubit.dart';
import 'package:fashion/features/mybasket/presentation/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/navigation_cubit.dart';
import '../cubit/navigation_state.dart';
import '../../../categories/presentation/pages/categories_page.dart';
import '../../../favorites/presentation/pages/favorites_page.dart';
import '../../../homepage/presentation/pages/home_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class MainPage extends StatelessWidget {
 final List<Widget> _pages = [
  HomePage(),
  BlocProvider(
    create: (_) => CategoryCubit(getCategories: injector<GetCategories>())..loadCategories(),
    child: const CategoriesPage(),
  ),
  CartPage(),
  FavoritesPage(),
  ProfilePage(),
];

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        final cubit = context.read<NavigationCubit>();

        return Scaffold(
          body: _pages[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) => cubit.changeTab(index),
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
                label: 'home'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.category_outlined),
                activeIcon: const Icon(Icons.category),
                label: 'categories'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart_outlined),
                activeIcon: const Icon(Icons.shopping_cart),
                label: 'my_basket'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite_outline),
                activeIcon: const Icon(Icons.favorite),
                label: 'favourites'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                activeIcon: const Icon(Icons.person),
                label: 'profile'.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}