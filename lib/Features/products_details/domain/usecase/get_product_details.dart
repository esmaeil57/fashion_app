import 'package:fashion/features/products_details/data/models/product_model.dart';
import '../repo_interface/product_repository.dart';

class GetProductDetails {
  final ProductRepository repository;
  GetProductDetails(this.repository);

  Future<List<ProductDetailsModel>> call(String productid) async {
    return await repository.getProductDetails(productid);
  }
}