import '../entities/product_category.dart';

abstract class ProductRepository {
  Future<List<ProductCategory>> getCategories();
  Future<List<dynamic>> getProductsByCategory(String categoryId);
  Future<List<dynamic>> searchProducts(String query);
}