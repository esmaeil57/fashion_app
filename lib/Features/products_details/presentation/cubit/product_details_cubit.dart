import 'package:fashion/features/products_details/domain/usecase/get_product_details.dart';
import 'package:fashion/features/products_details/presentation/cubit/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetails getProductDetails;
  final bool _isGridView = true;

  ProductDetailsCubit({required this.getProductDetails})
    : super(ProductInitial());

  void initializeForSingleProduct() {
    emit(ProductLoaded(products: [], isGridView: _isGridView));
  }

  Future<void> loadProducts(String productId) async {
    emit(ProductLoading());

    try {
      final products = await getProductDetails(productId);
      emit(ProductLoaded(products: products, isGridView: _isGridView));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void toggleFavorite(int productId) {
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
          selectedSize: currentState.selectedSize,
          selectedColor: currentState.selectedColor,
        ),
      );
    }
  }

  void toggleCart(int productId) {
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
          selectedSize: size,
          selectedColor: currentState.selectedColor,
        ),
      );
    } else {
      emit(
        ProductLoaded(
          products: [],
          isGridView: _isGridView,
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
          selectedSize: currentState.selectedSize,
          selectedColor: color,
        ),
      );
    } else {
      emit(
        ProductLoaded(
          products: [],
          isGridView: _isGridView,
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
          selectedSize: null,
          selectedColor: null,
        ),
      );
    }
  }
}
