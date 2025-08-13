import 'package:fashion/core/network/api/api_consumer.dart';
import 'package:fashion/core/network/api/end_points.dart';
import 'package:fashion/core/network/error/exceptions.dart';
import 'package:fashion/features/products/data/models/product_model.dart';
import 'package:fashion/features/products/domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProductsByCategory(String categoryId);
  Future<List<Product>> getAllProducts();
  Future<List<Product>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiConsumer apiConsumer;

  ProductRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    try {
      final response = await apiConsumer.get(
        EndPoints.productsListPerCategoryIdEndPoint,
        queryParameters: {
          'category': categoryId,
          'per_page': '50',
          'status': 'publish',
        },
      );

      return response.fold(
        (failure) => throw failure,
        (data) {
          if (data is! List) {
            throw const CustomException('Invalid response format');
          }
          return data
              .map<Product>(
                (json) => ProductModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();
        },
      );
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    try {
      final response = await apiConsumer.get(
        EndPoints.getAllProductsFilteredByFeaturedAndorderby,
        queryParameters: {
          'per_page': '50',
          'status': 'publish',
          'orderby': 'date',
          'order': 'desc',
        },
      );

      return response.fold(
        (failure) => throw failure,
        (data) {
          if (data is! List) {
            throw const CustomException('Invalid response format');
          }
          return data
              .map<Product>(
                (json) => ProductModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();
        },
      );
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await apiConsumer.get(
        EndPoints.searchInProductsEndPoint,
        queryParameters: {
          'search': query,
          'per_page': '50',
          'status': 'publish',
        },
      );

      return response.fold(
        (failure) => throw failure,
        (data) {
          if (data is! List) {
            throw const CustomException('Invalid response format');
          }
          return data
              .map<Product>(
                (json) => ProductModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();
        },
      );
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}
