import '../entities/product.dart';
import '../repo_interface/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<Product>> call(String categoryId) async {
    return await repository.getProductsByCategory(categoryId);
  }
}

class SearchProducts {
  final ProductRepository repository;

  SearchProducts(this.repository);

  Future<List<Product>> call(String query) async {
    return await repository.searchProducts(query);
  }
}