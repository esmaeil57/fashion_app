import 'package:fashion/features/categories/presentation/cubit/category_cubit.dart';
import 'package:fashion/features/categories/presentation/cubit/category_state.dart';
import 'package:fashion/features/categories/presentation/widgets/category_card.dart';
import 'package:fashion/core/common_widgets/search_bar.dart';
import 'package:fashion/core/common_widgets/shimmer_widget.dart';
import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<CategoryCubit>()..loadCategories(),
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Categories'),
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: Column(
          children: [
            const CustomSearchBar(),
            Expanded(
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const CategoryShimmerLoading();
                  }

                  if (state is CategoryError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Error: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<CategoryCubit>().loadCategories();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is CategoryLoaded) {
                    if (state.categories.isEmpty) {
                      return const Center(
                        child: Text('No categories available'),
                      );
                    }
                    
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<CategoryCubit>().loadCategories();
                      },
                      child: ListView.builder(
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          return CategoryCard(category: state.categories[index]);
                        },
                      ),
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