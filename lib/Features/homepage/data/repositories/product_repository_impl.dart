import '../../../../core/constants/app_constants.dart';
import '../../../categories/domain/entities/category.dart';
import '../../domain/entities/product_category.dart';
import '../../domain/repo_interface/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<ProductCategory>> getCategories() async {
    await Future.delayed(Duration(milliseconds: 500));

    final List<ProductCategory> categories = [];

    final data = AppConstants.categories.asMap().entries.map((entry) {
      return Category(
        id: entry.key.toString(),
        name: entry.value,
        imageUrl: 'assets/logo.png',
      );
    }).toList();
    for (var item in data) {
      categories.add(ProductCategory(
        id: item.id,
        name: item.name,
        iconPath: item.imageUrl,
      ));
    }

    return categories;
  }
  
  @override
  getProductsByCategory(String categoryId) {
    throw UnimplementedError();
  }
  
  @override
  searchProducts(String query) {
    throw UnimplementedError();
  }

}
