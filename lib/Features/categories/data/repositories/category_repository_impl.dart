import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api/api_consumer.dart';
import '../../../../core/network/api/end_points.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/category.dart';
import '../../domain/repo_interface/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final ApiConsumer apiConsumer;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({
    required this.apiConsumer,
    required this.networkInfo,
  });

  @override
  Future<List<Category>> getCategories() async {
    // Check network connectivity first
    if (await networkInfo.isConnected) {
      try {
        // Make API call to get categories
        final response = await apiConsumer.get(
          EndPoints.allCategoriesListEndPoint,
        );

        return response.fold(
          (failure) {
            // If API fails, fallback to static data
            print('API call failed, using static data: ${failure.message}');
            return _getStaticCategories();
          },
          (data) {
            // Parse API response
            if (data is List) {
              return data.map((categoryJson) {
                return Category(
                  id: categoryJson['id'].toString(),
                  name: categoryJson['name'] ?? 'Unknown Category',
                  imageUrl: categoryJson['image']?['src'] ?? 'assets/logo.png',
                );
              }).toList();
            } else {
              // If response format is unexpected, use static data
              print('Unexpected API response format, using static data');
              return _getStaticCategories();
            }
          },
        );
      } catch (e) {
        // If any error occurs, fallback to static data
        print('Error fetching categories: $e, using static data');
        return _getStaticCategories();
      }
    } else {
      // No internet connection, use static data
      print('No internet connection, using static data');
      return _getStaticCategories();
    }
  }

  // Fallback method for static categories
  List<Category> _getStaticCategories() {
    // Remove duplicates from static categories
    final uniqueCategories = <String, Category>{};
    
    AppConstants.categories.asMap().entries.forEach((entry) {
      final categoryName = entry.value;
      if (!uniqueCategories.containsKey(categoryName)) {
        uniqueCategories[categoryName] = Category(
          id: uniqueCategories.length.toString(),
          name: categoryName,
          imageUrl: 'assets/logo.png',
        );
      }
    });
    
    return uniqueCategories.values.toList();
  }
}