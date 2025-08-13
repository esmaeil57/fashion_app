import 'package:fashion/features/homepage/domain/repo_interface/product_repository.dart';
import 'package:fashion/features/products/domain/entities/product.dart';

class SearchProductsUsecase {
  final ProductRepository productRepository;

  SearchProductsUsecase({required this.productRepository});

  Future<List<Product>> call(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }
    return await productRepository.searchProducts(query.trim());
  }
}