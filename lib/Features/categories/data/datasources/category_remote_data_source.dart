import '../../../../core/network/api/api_consumer.dart';
import '../../../../core/network/api/end_points.dart';
import '../../../../core/network/error/exceptions.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories({int page = 1, int perPage = 10});
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiConsumer apiConsumer;

  CategoryRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<CategoryModel>> getCategories({int page = 1, int perPage = 10}) async {
    try {
      print(' Fetching categories - Page: $page, Per Page: $perPage');
      
      final response = await apiConsumer.get(
        EndPoints.allCategoriesListEndPoint,
        queryParameters: {
          'page': page,
          'per_page': perPage,
          'hide_empty': false,
          'orderby': 'name',
          'order': 'asc',
        },
      );

      return response.fold(
        (networkException) {
          print(' API Error on page $page: ${networkException.message}');
          throw networkException;
        },
        (data) {
          print('API Response received for page $page');
          
          if (data is List) {
            print('Found ${data.length} categories on page $page');
            
            final categories = data.map((categoryJson) {
              return CategoryModel.fromJson(categoryJson);
            }).toList();
            
            print('Successfully parsed ${categories.length} categories for page $page');
            return categories;
          } else {
            throw const CustomException('Unexpected API response format');
          }
        },
      );
    } catch (e) {
      print('Exception fetching page $page: $e');
      rethrow;
    }
  }
}