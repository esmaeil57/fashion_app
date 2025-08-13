import 'package:fashion/features/products/domain/entities/product.dart';

import '../entities/product_category.dart';

abstract class ProductRepository {
  Future<List<ProductCategory>> getCategories();
  Future<List<dynamic>> getProductsByCategory(String categoryId);
  Future<List<Product>> searchProducts(String query);
}