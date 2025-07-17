import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/category.dart';
import '../../domain/repo_interface/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return AppConstants.categories.asMap().entries.map((entry) {
      return Category(
        id: entry.key.toString(),
        name: entry.value,
        imageUrl: 'assets/logo.png', 
      );
    }).toList();
  }
}