import 'package:fashion/features/categories/presentation/cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_categories.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategories getCategories;

  CategoryCubit({required this.getCategories}) : super(CategoryInitial());

  Future<void> loadCategories() async {
    emit(CategoryLoading());
    
    try {
      final categories = await getCategories();
      if (categories.isEmpty) {
        emit(const CategoryError('No categories found'));
      } else {
        emit(CategoryLoaded(categories));
      }
    } catch (e) {
      emit(CategoryError('Failed to load categories: ${e.toString()}'));
    }
  }

  void refreshCategories() {
    loadCategories();
  }
}