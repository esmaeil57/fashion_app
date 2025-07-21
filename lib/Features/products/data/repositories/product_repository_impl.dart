import '../../domain/entities/product.dart';
import '../../domain/repo_interface/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final List<Product> _mockProducts = [
    Product(
      id: '1',
      name: 'Paris Green T-shirt',
      imageUrl: 'assets/image1.jpg',
      price: 45.0,
      categoryId: '0',
      colors: ['Black', 'Navy'],
      sizes: ['One Size'],
    ),
    Product(
      id: '2',
      name: 'Forever 21 Yellow pants',
      imageUrl: 'assets/image2.jpg',
      price: 925.0,
      categoryId: '0',
      colors: ['Black'],
      sizes: ['One Size'],
    ),
    Product(
      id: '3',
      name: 'Forever 21 ',
      imageUrl: 'assets/image3.jpg',
      price: 35.0,
      categoryId: '0',
      colors: ['Green'],
      sizes: ['One Size'],
    ),
    Product(
      id: '4',
      name: 'Eden Park white Tops& T-Shirts',
      imageUrl: 'assets/image4.jpg',
      price: 75.0,
      categoryId: '0',
      colors: ['White'],
      sizes: ['One Size'],
    ),
    Product(
      id: '5',
      name: 'Vintage Denim Jacket',
      imageUrl: 'assets/image2.jpg',
      price: 129.0,
      categoryId: '1',
      colors: ['Blue', 'Light Blue'],
      sizes: ['S', 'M', 'L', 'XL'],
    ),
    Product(
      id: '6',
      name: 'Classic White T-Shirt',
      imageUrl: 'assets/image3.jpg',
      price: 25.0,
      categoryId: '2',
      colors: ['White', 'Black', 'Gray'],
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
    ),
  ];

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Return all products regardless of category
    return _mockProducts;
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (query.isEmpty) {
      return _mockProducts;
    }

    return _mockProducts
        .where(
          (product) => product.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  Future<List<Product>> getCategories() => throw UnimplementedError();
}