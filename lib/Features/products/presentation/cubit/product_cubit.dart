import 'package:fashion/features/products/domain/entities/product.dart';
import 'package:fashion/features/products/presentation/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_products.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts getProducts;
  final GetAllProducts getAllProducts;
  final SearchProducts searchProducts;

  String _currentCategoryId = '';
  bool _isGridView = true;
  String _searchQuery = '';

  ProductCubit({
    required this.getAllProducts,
    required this.getProducts,
    required this.searchProducts,
  }) : super(ProductInitial());

  Future<void> loadProducts(String categoryId) async {
    _currentCategoryId = categoryId;
    emit(ProductLoading());

    try {
      final products = await getProducts(categoryId);
      emit(
        ProductLoaded(
          products: products,
          isGridView: _isGridView,
          searchQuery: _searchQuery,
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> loadAllProducts() async {
    _currentCategoryId = 'all';
    emit(ProductLoading());

    try {
      final products = await getAllProducts();
      emit(
        ProductLoaded(
          products: products,
          isGridView: _isGridView,
          searchQuery: _searchQuery,
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void toggleFavorite(String productId) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;

      final updatedProducts =
          currentState.products.map((product) {
            if (product.id == productId) {
              return product.copyWith(isFavorite: !product.isFavorite);
            }
            return product;
          }).toList();

      emit(
        ProductLoaded(
          products: updatedProducts,
          isGridView: currentState.isGridView,
          searchQuery: currentState.searchQuery,
          selectedSize: currentState.selectedSize,
          selectedColor: currentState.selectedColor,
        ),
      );
    }
  }

  void toggleCart(String productId) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;

      final updatedProducts =
          currentState.products.map((product) {
            if (product.id == productId) {
              return product.copyWith(isAddedToCart: !product.isAddedToCart);
            }
            return product;
          }).toList();

      emit(
        ProductLoaded(
          products: updatedProducts,
          isGridView: currentState.isGridView,
          searchQuery: currentState.searchQuery,
          selectedSize: currentState.selectedSize,
          selectedColor: currentState.selectedColor,
        ),
      );
    }
  }

  void selectSize(String size) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      emit(
        ProductLoaded(
          products: currentState.products,
          isGridView: currentState.isGridView,
          searchQuery: currentState.searchQuery,
          selectedSize: size,
          selectedColor: currentState.selectedColor,
        ),
      );
    }
  }

  void selectColor(String color , int colorIndex) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      emit(
        ProductLoaded(
          products: currentState.products,
          isGridView: currentState.isGridView,
          searchQuery: currentState.searchQuery,
          selectedSize: currentState.selectedSize,
          selectedColor: color,
        ),
      );
    }
  }

  void toggleViewMode() {
    _isGridView = !_isGridView;
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      emit(
        ProductLoaded(
          products: currentState.products,
          isGridView: _isGridView,
          searchQuery: _searchQuery,
          selectedSize: currentState.selectedSize,
          selectedColor: currentState.selectedColor,
        ),
      );
    }
  }

  Future<void> searchProductsInCategory(String query) async {
    _searchQuery = query;

    if (query.isEmpty) {
      // If query is empty, reload the original products
      await loadProducts(_currentCategoryId);
      return;
    }

    emit(ProductLoading());

    try {
      List<Product> products;

      if (_currentCategoryId == 'all') {
        // Search in all products using the API search endpoint
        products = await searchProducts(query);
      } else {
        // Get products by category first, then filter by search query
        final allProducts = await getProducts(_currentCategoryId);
        products =
            allProducts
                .where(
                  (product) =>
                      product.name.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      product.description.toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                )
                .toList();
      }

      emit(
        ProductLoaded(
          products: products,
          isGridView: _isGridView,
          searchQuery: _searchQuery,
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void clearSearch() {
    _searchQuery = '';
    if (_currentCategoryId == 'all') {
      loadAllProducts();
    } else {
      loadProducts(_currentCategoryId);
    }
  }

  // Method to filter products by category (used when categories are mixed)
  void filterByCategory(String categoryId) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;

      if (categoryId == 'all') {
        loadAllProducts();
        return;
      }

      final filteredProducts =
          currentState.products
              .where((product) => product.categoryId == categoryId)
              .toList();

      emit(
        ProductLoaded(
          products: filteredProducts,
          isGridView: currentState.isGridView,
          searchQuery: currentState.searchQuery,
          selectedSize: currentState.selectedSize,
          selectedColor: currentState.selectedColor,
        ),
      );
    }
  }

  // Method to sort products
  void sortProducts(String sortBy) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final sortedProducts = List<Product>.from(currentState.products);

      switch (sortBy.toLowerCase()) {
        case 'price_low_to_high':
          sortedProducts.sort(
            (a, b) => a.effectivePrice.compareTo(b.effectivePrice),
          );
          break;
        case 'price_high_to_low':
          sortedProducts.sort(
            (a, b) => b.effectivePrice.compareTo(a.effectivePrice),
          );
          break;
        default:
          break;
      }

      emit(
        ProductLoaded(
          products: sortedProducts,
          isGridView: currentState.isGridView,
          searchQuery: currentState.searchQuery,
          selectedSize: currentState.selectedSize,
          selectedColor: currentState.selectedColor,
        ),
      );
    }
  }
}
