import 'dart:convert';
import 'package:fashion/features/products/data/models/product_model.dart';
import 'package:fashion/features/products/domain/entities/product.dart';
import '../../../../core/network/api/api_consumer.dart';
import '../../../../core/network/api/end_points.dart';
import '../../domain/entities/product_category.dart';
import '../../domain/repo_interface/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiConsumer apiConsumer;

  ProductRepositoryImpl({required this.apiConsumer});

  @override
  Future<List<ProductCategory>> getCategories() async {
    final result = await apiConsumer.get(EndPoints.categoriesListEndPoint);

    return result.fold(
      (error) => throw error,
      (data) {
        final List<dynamic> categoryList =
            data is String ? json.decode(data) : data;

        return categoryList
            .map<ProductCategory>(
              (item) => ProductCategory(
                id: item['id'].toString(),
                name: item['name'] ?? '',
                iconPath: item['image']?['src'] ?? 'assets/logo.png',
              ),
            )
            .toList();
      },
    );
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    final result = await apiConsumer.get(
      EndPoints.productsListPerCategoryIdEndPoint,
      queryParameters: {'category': categoryId},
    );

    return result.fold(
      (error) => throw error,
      (data) {
        final List<dynamic> productList =
            data is String ? json.decode(data) : data;

        return productList
            .map<Product>(
              (json) => ProductModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      },
    );
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final result = await apiConsumer.get(
      EndPoints.searchInProductsEndPoint,
      queryParameters: {'search': query},
    );

    return result.fold(
      (error) => throw error,
      (data) {
        final List<dynamic> productList =
            data is String ? json.decode(data) : data;

        return productList
            .map<Product>(
              (json) => ProductModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      },
    );
  }
}
