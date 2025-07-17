import '../../domain/entities/product_category.dart';
import '../../domain/repo_interface/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<ProductCategory>> getCategories() async {
    await Future.delayed(Duration(milliseconds: 500));

    final List<ProductCategory> categories = [];

    final data = [
      {'id': '1', 'name': 'Accessories'},
      {'id': '2', 'name': 'Accessories'},
      {'id': '3', 'name': 'Accessories'},
      {'id': '4', 'name': 'Activewear'},
      {'id': '5', 'name': 'Activewear'},
      {'id': '6', 'name': 'Baby'},
      {'id': '7', 'name': 'Activewear'},
      {'id': '8', 'name': 'Baby Doll'},
      {'id': '9', 'name': 'Backpacks'},
      {'id': '10', 'name': 'Backpacks'},
      {'id': '11', 'name': 'Bags'},
      {'id': '12', 'name': 'Bags'},
    ];

    for (var item in data) {
      categories.add(ProductCategory(
        id: item['id']!,
        name: item['name']!,
        iconPath: 'assets/logo.png',
      ));
    }

    return categories;
  }
}
