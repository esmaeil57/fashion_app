import 'package:fashion/core/network/api/api_consumer.dart';
import 'package:fashion/core/network/api/end_points.dart';
import 'package:fashion/core/network/error/exceptions.dart';
import 'package:fashion/features/products_details/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductDetailsModel>> getProductDetails(String productid);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiConsumer apiConsumer;

  ProductRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<ProductDetailsModel>> getProductDetails(String productid) async {
    try {
      final response = await apiConsumer.get(
        '${EndPoints.getProductDetailsEndPoint}$productid',
      );

      return response.fold((failure) => throw failure, (data) {
        if (data is! List) {
          throw const CustomException('Invalid response format');
        }
        return data
            .map<ProductDetailsModel>(
              (json) =>
                  ProductDetailsModel.fromJson(json as Map<String, dynamic>,),
            )
            .toList();
      });
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}
