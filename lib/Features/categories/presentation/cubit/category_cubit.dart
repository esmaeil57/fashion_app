import 'package:fashion/features/categories/domain/entities/category.dart';
import 'package:fashion/features/categories/presentation/cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_categories.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategories getCategories;

  static const int _categoriesPerPage = 10;

  CategoryCubit({required this.getCategories}) : super(CategoryInitial());

  Future<void> loadCategories() async {
    print(' CategoryCubit: Loading first page of categories...');
    emit(CategoryLoading());

    try {
      final categories = await getCategories(
        page: 1,
        perPage: _categoriesPerPage,
      );
      print(
        ' CategoryCubit: Loaded ${categories.length} categories for first page',
      );

      final hasReachedMax = categories.length < _categoriesPerPage;

      emit(
        CategoryLoaded(
          categories: categories,
          hasReachedMax: hasReachedMax,
          currentPage: 1,
        ),
      );

      // Log summary info
      print(' Total categories loaded: ${categories.length}');
      print(' Current page: 1');
      print(' Has reached max: $hasReachedMax');
    } catch (e) {
      print(' CategoryCubit: Error loading first page: $e');
      emit(CategoryError('Failed to load categories: ${e.toString()}'));
    }
  }

  Future<void> loadMoreCategories() async {
    final currentState = state;
    if (currentState is! CategoryLoaded) {
      print(
        ' CategoryCubit: Cannot load more - invalid state: ${currentState.runtimeType}',
      );
      return;
    }

    if (currentState.hasReachedMax) {
      print(' CategoryCubit: Cannot load more - reached maximum');
      return;
    }

    if (currentState.isLoadingMore) {
      print(' CategoryCubit: Already loading more categories');
      return;
    }

    final nextPage = currentState.currentPage + 1;
    print(' CategoryCubit: Loading more categories - page $nextPage');

    // Show loading indicator for "load more"
    emit(currentState.copyWith(isLoadingMore: true));

    try {
      final newCategories = await getCategories(
        page: nextPage,
        perPage: _categoriesPerPage,
      );
      print(' CategoryCubit: Loaded ${newCategories.length} more categories');

      final hasReachedMax = newCategories.length < _categoriesPerPage;
      final allCategories = List<Category>.from(currentState.categories)
        ..addAll(newCategories);

      emit(
        CategoryLoaded(
          categories: allCategories,
          hasReachedMax: hasReachedMax,
          currentPage: nextPage,
          isLoadingMore: false,
        ),
      );

      // Log updated summary
      print(' Total categories loaded: ${allCategories.length}');
      print(' Current page: $nextPage');
      print(' Has reached max: $hasReachedMax');
    } catch (e) {
      print(' CategoryCubit: Error loading more categories: $e');
      // Revert loading state but keep existing categories
      emit(currentState.copyWith(isLoadingMore: false));

      // Optionally emit a temporary error state for load more failures
      _showLoadMoreError(e.toString());
    }
  }

  void refreshCategories() {
    print('🔄 CategoryCubit: Refreshing categories...');
    loadCategories();
  }

  // Additional helper methods

  void retryLoadMore() {
    print(' CategoryCubit: Retrying load more...');
    loadMoreCategories();
  }

  void _showLoadMoreError(String errorMessage) {
    // You could emit a temporary error state or use a callback
    // For now, just log it - you could extend this to show snackbars
    print(' Load More Error: $errorMessage');
  }
}
