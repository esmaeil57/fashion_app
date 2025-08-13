import 'package:fashion/features/categories/presentation/cubit/category_cubit.dart';
import 'package:fashion/features/categories/presentation/cubit/category_state.dart';
import 'package:fashion/features/categories/presentation/widgets/category_card.dart';
import 'package:fashion/core/shared_widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared_widgets/enhanced_search_bar.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<CategoryCubit>().loadMoreCategories();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search bar for categories page
          const EnhancedSearchBar(
            hintText: 'Search products...',
            margin: EdgeInsets.fromLTRB(20, 40, 20, 16),
          ),
          Expanded(
            child: BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const CategoryShimmerLoading();
                }

                if (state is CategoryError) {
                  return _buildErrorWidget(context, state.message);
                }

                if (state is CategoryLoaded) {
                  return _buildCategoryList(context, state);
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            'Error: $message',
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

  Widget _buildCategoryList(BuildContext context, CategoryLoaded state) {
    if (state.categories.isEmpty) {
      return const Center(child: Text('No categories available'));
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<CategoryCubit>().refreshCategories();
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount:
            state.hasReachedMax
                ? state.categories.length
                : state.categories.length + 1,
        itemBuilder: (context, index) {
          if (index >= state.categories.length) {
            return _buildBottomLoader(state.isLoadingMore);
          }
          return CategoryCard(category: state.categories[index]);
        },
      ),
    );
  }

  Widget _buildBottomLoader(bool isLoadingMore) {
    if (isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Scroll to load more categories...',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }
  }
}
