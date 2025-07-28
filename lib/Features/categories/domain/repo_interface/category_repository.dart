import '../entities/category.dart';


abstract class CategoryRepository {
  Future<List<Category>> getCategories({int page = 1, int perPage = 10});
}