import 'package:fashion/features/categories/presentation/cubit/category_cubit.dart';
import 'package:fashion/features/categories/presentation/cubit/category_state.dart';
import 'package:fashion/features/categories/presentation/widgets/category_card.dart';
import 'package:fashion/core/common_widgets/search_bar.dart';
import 'package:fashion/core/common_widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/category_repository_impl.dart';
import '../../domain/usecase/get_categories.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => CategoryCubit(
            getCategories: GetCategories(CategoryRepositoryImpl()),
          )..loadCategories(),
      child: Scaffold(
        body: Column(
          children: [
            CustomSearchBar(),
            Expanded(
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const CategoryShimmerLoading();
                  }

                  if (state is CategoryError) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (state is CategoryLoaded) {
                    return ListView.builder(
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        return CategoryCard(category: state.categories[index]);
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
