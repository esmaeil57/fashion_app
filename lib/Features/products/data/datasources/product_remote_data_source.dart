import 'package:fashion/core/network/api/api_consumer.dart';
import 'package:fashion/core/network/api/end_points.dart';
import 'package:fashion/core/network/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProductsByCategory(String categoryId);
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiConsumer apiConsumer;

  ProductRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      final response = await apiConsumer.get(
        EndPoints.productsListPerCategoryIdEndPoint,
        queryParameters: {
          'category': categoryId,
          'per_page': '50', // Adjust as needed
          'status': 'publish',
        },
      );

      return response.fold(
        (failure) => throw failure,
        (data) {
          if (data is List) {
            return data
                .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
                .toList();
          } else {
            throw const CustomException('Invalid response format');
          }
        },
      );
    } catch (e) {
      if (e is NetworkException) {
        rethrow;
      }
      throw CustomException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await apiConsumer.get(
        EndPoints.getAllProductsFilteredByFeaturedAndorderby,
        queryParameters: {
          'per_page': '50', // Adjust as needed
          'status': 'publish',
          'orderby': 'date',
          'order': 'desc',
        },
      );

      return response.fold(
        (failure) => throw failure,
        (data) {
          if (data is List) {
            return data
                .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
                .toList();
          } else {
            throw const CustomException('Invalid response format');
          }
        },
      );
    } catch (e) {
      if (e is NetworkException) {
        rethrow;
      }
      throw CustomException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
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
          if (data is List) {
            return data
                .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
                .toList();
          } else {
            throw const CustomException('Invalid response format');
          }
        },
      );
    } catch (e) {
      if (e is NetworkException) {
        rethrow;
      }
      throw CustomException(e.toString());
    }
  }
}