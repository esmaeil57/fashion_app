import '../entities/product_category.dart';

abstract class ProductRepository {
  Future<List<ProductCategory>> getCategories();
}
