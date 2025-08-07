import 'dart:convert';
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
        final List<ProductCategory> categories = [];
        
        // Handle the response data
        final List<dynamic> categoryList = data is String ? json.decode(data) : data;
        
        for (var item in categoryList) {
          categories.add(ProductCategory(
            id: item['id'].toString(),
            name: item['name'] ?? '',
            iconPath: item['image']?['src'] ?? 'assets/logo.png',
          ));
        }
        
        return categories;
      },
    );
  }
  
  @override
  Future<List<dynamic>> getProductsByCategory(String categoryId) async {
    final result = await apiConsumer.get(
      EndPoints.productsListPerCategoryIdEndPoint,
      queryParameters: {'category': categoryId},
    );
    
    return result.fold(
      (error) => throw error,
      (data) {
        final List<dynamic> productList = data is String ? json.decode(data) : data;
        return productList;
      },
    );
  }
  
  @override
  Future<List<dynamic>> searchProducts(String query) async {
    final result = await apiConsumer.get(
      EndPoints.searchInProductsEndPoint,
      queryParameters: {'search': query},
    );
    
    return result.fold(
      (error) => throw error,
      (data) {
        final List<dynamic> productList = data is String ? json.decode(data) : data;
        return productList;
      },
    );
  }
}