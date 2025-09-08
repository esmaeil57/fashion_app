import 'package:fashion/features/products_details/data/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductDetailsModel>> getProductDetails(String productid);
}
