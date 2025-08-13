import 'package:fashion/features/products/domain/entities/product.dart';

class SearchResult {
  final String query;
  final List<Product> products;
  final int totalCount;

  SearchResult({
    required this.query,
    required this.products,
    required this.totalCount,
  });
}