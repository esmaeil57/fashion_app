import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/search_result.dart';
import '../../domain/usecases/search_products_usecase.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchProductsUsecase searchProductsUsecase;
  Timer? _debounceTimer;
  static const Duration _debounceDuration = Duration(milliseconds: 500);

  SearchCubit({required this.searchProductsUsecase}) : super(SearchInitial());

  void searchProducts(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();
    
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());

    // Start new timer
    _debounceTimer = Timer(_debounceDuration, () async {
      try {
        print('Searching for: $query');
        final products = await searchProductsUsecase.call(query);
        
        final searchResult = SearchResult(
          query: query,
          products: products,
          totalCount: products.length,
        );
        
        emit(SearchLoaded(searchResult: searchResult));
        print('Search completed: ${products.length} products found');
      } catch (error) {
        print('Search error: $error');
        emit(SearchError(message: error.toString()));
      }
    });
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    emit(SearchInitial());
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}