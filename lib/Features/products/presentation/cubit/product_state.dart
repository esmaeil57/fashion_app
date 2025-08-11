import '../../domain/entities/product.dart';

abstract class ProductState {
  final String? selectedSize;
  final String? selectedColor;
    final int? selectedColorIndex;
  const ProductState({this.selectedSize, this.selectedColor ,this.selectedColorIndex});
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  @override
  final int? selectedColorIndex;
  final bool isGridView;
  final String searchQuery;

  const ProductLoaded({
    required this.products,
    this.selectedColorIndex,
    this.isGridView = false,
    this.searchQuery = '',
    super.selectedSize,
    super.selectedColor,
  });

  @override
  List<Object> get props => [
    products,
    isGridView,
    searchQuery,
    selectedSize ?? '',
    selectedColor ?? '',
    selectedColorIndex ?? 0,
  ];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
