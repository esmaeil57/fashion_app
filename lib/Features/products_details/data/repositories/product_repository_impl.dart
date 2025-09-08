import 'package:fashion/core/network/error/exceptions.dart';
import 'package:fashion/core/network/network_info.dart';
import 'package:fashion/features/products_details/data/datasources/product_remote_data_source.dart';
import 'package:fashion/features/products_details/data/models/product_model.dart';
import 'package:fashion/features/products_details/domain/repo_interface/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<ProductDetailsModel>> getProductDetails(String productid) async {
    if (await networkInfo.isConnected) {
      try {
        final productDetails = await remoteDataSource.getProductDetails(productid);
        return productDetails;
      } on NetworkException {
        rethrow;
      } catch (e) {
        throw CustomException(e.toString());
      }
    } else {
      throw NoInternetConnectionException();
    }
  }
  

}
