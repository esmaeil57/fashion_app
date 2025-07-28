import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/category.dart';
import '../../domain/repo_interface/category_repository.dart';
import '../datasources/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Category>> getCategories({int page = 1, int perPage = 10}) async {
    print(' CategoryRepository: getCategories page $page, perPage $perPage');
    
    if (await networkInfo.isConnected) {
      try {
        final remoteCategories = await remoteDataSource.getCategories(
          page: page,
          perPage: perPage,
        );
        
        print(' Repository: Fetched ${remoteCategories.length} categories for page $page');
        return remoteCategories;
        
      } on NetworkException catch (e) {
        print(' Network exception on page $page: ${e.message}');
        // For first page, return static data; for other pages, throw error
        if (page == 1) {
          return _getStaticCategories(page: page, perPage: perPage);
        } else {
          throw e;
        }
      } catch (e) {
        print(' General exception on page $page: $e');
        if (page == 1) {
          return _getStaticCategories(page: page, perPage: perPage);
        } else {
          throw e;
        }
      }
    } else {
      print(' No internet - using static data for page $page');
      return _getStaticCategories(page: page, perPage: perPage);
    }
  }

  List<Category> _getStaticCategories({int page = 1, int perPage = 10}) {
    // Create unique categories from static data
    final uniqueCategories = <String, Category>{};
    
    for (var categoryName in AppConstants.categories) {
      if (!uniqueCategories.containsKey(categoryName)) {
        uniqueCategories[categoryName] = Category(
          id: uniqueCategories.length.toString(),
          name: categoryName,
          imageUrl: 'assets/logo.png',
        );
      }
    }
    
    final allCategories = uniqueCategories.values.toList();
    
    // Implement pagination for static data
    final startIndex = (page - 1) * perPage;
    final endIndex = startIndex + perPage;
    
    if (startIndex >= allCategories.length) {
      return []; 
    }
    
    final paginatedCategories = allCategories.sublist(
      startIndex,
      endIndex > allCategories.length ? allCategories.length : endIndex,
    );
    
    print(' Static data: Returning ${paginatedCategories.length} categories for page $page');
    return paginatedCategories;
  }
}
