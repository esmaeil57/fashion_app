import 'package:fashion/features/homepage/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_categories_usecase.dart';
import '../../../../core/network/error/exceptions.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  HomeCubit(this.getCategoriesUseCase) : super(HomeInitial());

  Future<void> loadCategories() async {
    try {
      emit(HomeLoading());
      final categories = await getCategoriesUseCase();
      emit(HomeLoaded(categories));
    } on NetworkException catch (e) {
      emit(HomeError(e.message ?? 'Network error occurred'));
    } catch (e) {
      emit(HomeError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  void retry() {
    loadCategories();
  }
}