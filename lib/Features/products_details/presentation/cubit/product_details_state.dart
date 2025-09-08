import 'package:fashion/features/products_details/data/models/product_model.dart';

abstract class ProductDetailsState {
  final String? selectedSize;
  final String? selectedColor;
    final int? selectedColorIndex;
  const ProductDetailsState({this.selectedSize, this.selectedColor ,this.selectedColorIndex});
  List<Object> get props => [];
}

class ProductInitial extends ProductDetailsState {}

class ProductLoading extends ProductDetailsState {}

class ProductLoaded extends ProductDetailsState {
  final List<ProductDetailsModel> products;
  @override
  final int? selectedColorIndex;
  final bool isGridView;
  

  const ProductLoaded({
    required this.products,
    this.selectedColorIndex,
    this.isGridView = false,
    super.selectedSize,
    super.selectedColor,
  });

  @override
  List<Object> get props => [
    products,
    isGridView,
    selectedSize ?? '',
    selectedColor ?? '',
    selectedColorIndex ?? 0,
  ];
}

class ProductError extends ProductDetailsState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
