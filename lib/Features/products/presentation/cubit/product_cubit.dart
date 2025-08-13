import 'package:fashion/features/products/domain/entities/product.dart';
import 'package:fashion/features/products/presentation/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_products.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts getProducts;
  final GetAllProducts getAllProducts;
  bool _isGridView = true;
  final String _searchQuery = '';

  // Store the unmodified product list for "recommended" sorting
  List<Product> _originalProducts = [];

  ProductCubit({
    required this.getAllProducts,
    required this.getProducts,
  }) : super(ProductInitial());

  void initializeForSingleProduct() {
    emit(
      ProductLoaded(
        products: [],
        isGridView: _isGridView,
        searchQuery: _searchQuery,
      ),
    );
  }

  Future<void> loadProducts(String categoryId) async {
    emit(ProductLoading());

    try {
      final products = await getProducts(categoryId);
      _originalProducts = List<Product>.from(products); // Save original order
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
    emit(ProductLoading());

    try {
      final products = await getAllProducts();
      _originalProducts = List<Product>.from(products); // Save original order
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

      final updatedProducts = currentState.products.map((product) {
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

      final updatedProducts = currentState.products.map((product) {
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
    } else {
      emit(
        ProductLoaded(
          products: [],
          isGridView: _isGridView,
          searchQuery: _searchQuery,
          selectedSize: size,
          selectedColor: null,
        ),
      );
    }
  }

  void selectColor(String color, int colorIndex) {
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
    } else {
      emit(
        ProductLoaded(
          products: [],
          isGridView: _isGridView,
          searchQuery: _searchQuery,
          selectedSize: null,
          selectedColor: color,
        ),
      );
    }
  }

  void clearSelections() {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      emit(
        ProductLoaded(
          products: currentState.products,
          isGridView: currentState.isGridView,
          searchQuery: currentState.searchQuery,
          selectedSize: null,
          selectedColor: null,
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

  void filterByCategory(String categoryId) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;

      if (categoryId == 'all') {
        loadAllProducts();
        return;
      }

      final filteredProducts = currentState.products
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

  void sortProducts(String sortBy) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      List<Product> sortedProducts;

      switch (sortBy.toLowerCase()) {
        case 'price_low_to_high':
          sortedProducts = List<Product>.from(currentState.products)
            ..sort((a, b) => a.effectivePrice.compareTo(b.effectivePrice));
          break;
        case 'price_high_to_low':
          sortedProducts = List<Product>.from(currentState.products)
            ..sort((a, b) => b.effectivePrice.compareTo(a.effectivePrice));
          break;
        case 'recommended':
        default:
          sortedProducts = List<Product>.from(_originalProducts);
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
