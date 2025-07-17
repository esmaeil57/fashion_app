import '../entities/product_category.dart';
import '../repo_interface/product_repository.dart';

class GetCategoriesUseCase {
  final ProductRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<ProductCategory>> call() async {
    return await repository.getCategories();
  }
}
