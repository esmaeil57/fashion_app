import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/navigation_cubit.dart';
import '../cubit/navigation_state.dart';
import '../../../homepage/presentation/pages/basket_page.dart';
import '../../../homepage/presentation/pages/categories_page.dart';
import '../../../homepage/presentation/pages/favourites_page.dart';
import '../../../homepage/presentation/pages/home_page.dart';
import '../../../homepage/presentation/pages/profile_page.dart';

class MainPage extends StatelessWidget {
  final List<Widget> _pages = [
    HomePage(),
    CategoriesPage(),
    BasketPage(),
    FavouritesPage(),
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
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                activeIcon: Icon(Icons.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                activeIcon: Icon(Icons.shopping_cart),
                label: 'My Basket',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                activeIcon: Icon(Icons.favorite),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
