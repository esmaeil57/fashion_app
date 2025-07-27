import 'package:fashion/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductsByCategory(String categoryId);
  Future<List<Product>> searchProducts(String query);
    Future<List<Product>> getAllProducts();
}