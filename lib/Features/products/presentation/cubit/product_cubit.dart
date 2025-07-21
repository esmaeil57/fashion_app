import 'package:fashion/Features/products/domain/entities/product.dart';
import 'package:fashion/Features/products/presentation/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_products.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts getProducts;
  final SearchProducts searchProducts;
  
  String _currentCategoryId = '';
  bool _isGridView = true;
  String _searchQuery = '';

  ProductCubit({
    required this.getProducts,
    required this.searchProducts,
  }) : super(ProductInitial());

  Future<void> loadProducts(String categoryId) async {
    _currentCategoryId = categoryId;
    emit(ProductLoading());
    
    try {
      final products = await getProducts(categoryId);
      emit(ProductLoaded(
        products: products,
        isGridView: _isGridView,
        searchQuery: _searchQuery,
      ));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

void toggleFavorite(String productId) {
  if (state is ProductLoaded) {
    final currentState = state as ProductLoaded;

    final updatedProducts = currentState.products.map((product) {
      if (product.id == productId) {
        return Product(
          id: product.id,
          name: product.name,
          imageUrl: product.imageUrl,
          price: product.price,
          categoryId: product.categoryId,
          isFavorite: !product.isFavorite,
          colors: product.colors,
          sizes: product.sizes,
        );
      }
      return product;
    }).toList();

    emit(ProductLoaded(
      products: updatedProducts,
      isGridView: currentState.isGridView,
      searchQuery: currentState.searchQuery,
    ));
  }
}

void toggleCart(String productId) {
  if (state is ProductLoaded) {
    final currentState = state as ProductLoaded;

    final updatedProducts = currentState.products.map((product) {
      if (product.id == productId) {
        return Product(
          id: product.id,
          name: product.name,
          imageUrl: product.imageUrl,
          price: product.price,
          categoryId: product.categoryId,
          isAddedToCart: !product.isAddedToCart,
          colors: product.colors,
          sizes: product.sizes,
        );
      }
      return product;
    }).toList();

    emit(ProductLoaded(
      products: updatedProducts,
      isGridView: currentState.isGridView,
      searchQuery: currentState.searchQuery,
    ));
  }
}

void selectSize(String size) {
  if (state is ProductLoaded) {
    final currentState = state as ProductLoaded;
    emit(ProductLoaded(
      products: currentState.products,
      isGridView: currentState.isGridView,
      searchQuery: currentState.searchQuery,
      selectedSize: size,
      selectedColor: currentState.selectedColor,
    ));
  }
}

void selectColor(String color) {
  if (state is ProductLoaded) {
    final currentState = state as ProductLoaded;
    emit(ProductLoaded(
      products: currentState.products,
      isGridView: currentState.isGridView,
      searchQuery: currentState.searchQuery,
      selectedSize: currentState.selectedSize,
      selectedColor: color,
    ));
  }
}

  void toggleViewMode() {
    _isGridView = !_isGridView;
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      emit(ProductLoaded(
        products: currentState.products,
        isGridView: _isGridView,
        searchQuery: _searchQuery,
      ));
    }
  }

  Future<void> searchProductsInCategory(String query) async {
    _searchQuery = query;
    
    if (state is ProductLoaded) {
      emit(ProductLoading());
      
      try {
        final allProducts = await getProducts(_currentCategoryId);
        final filteredProducts = allProducts.where((product) => 
          product.name.toLowerCase().contains(query.toLowerCase())
        ).toList();
        
        emit(ProductLoaded(
          products: filteredProducts,
          isGridView: _isGridView,
          searchQuery: _searchQuery,
        ));
      } catch (e) {
        emit(ProductError(e.toString(),));
      }
    }
  }

  void clearSearch() {
    _searchQuery = '';
    loadProducts(_currentCategoryId);
  }
}
