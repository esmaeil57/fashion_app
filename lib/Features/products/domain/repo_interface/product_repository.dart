import 'package:fashion/Features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductsByCategory(String categoryId);
  Future<List<Product>> searchProducts(String query);
}