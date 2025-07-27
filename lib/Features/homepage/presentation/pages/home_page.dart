import 'package:fashion/features/homepage/presentation/widgets/carousel_slider_plus.dart';
import 'package:fashion/core/common_widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_categories_usecase.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/category_grid.dart';
import '../widgets/product_banner.dart';
import '../../data/repositories/product_repository_impl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              HomeCubit(GetCategoriesUseCase(ProductRepositoryImpl()))
                ..loadCategories(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Search Bar
                CustomSearchBar(),
                SizedBox(height: 10),
                //Carousal
                VerticalSlider(),
                SizedBox(height: 20),
                // Categories Grid
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is HomeLoaded) {
                      return CategoryGrid(categories: state.categories);
                    } else if (state is HomeError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return Container();
                  },
                ),
                SizedBox(height: 10),
                // Banner Section
                ProductBanner(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
