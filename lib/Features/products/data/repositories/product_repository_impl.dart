import 'package:fashion/features/homepage/domain/entities/product_category.dart';
import 'package:fashion/features/products/domain/repo_interface/product_repository.dart';
import 'package:fashion/features/products/domain/entities/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  final List<Product> _mockProducts = [
    Product(
      id: '1',
      name: 'Paris Green T-shirt',
      imageUrl: 'assets/image1.jpg',
      price: 45.0,
      categoryId: '1',
      colors: ['Black', 'Navy'],
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
    ),
    Product(
      id: '2',
      name: 'Forever 21 Yellow pants',
      imageUrl: 'assets/image2.jpg',
      price: 925.0,
      categoryId: '1',
      colors: ['Black','Yellow'],
      sizes: ['One Size'],
    ),
    Product(
      id: '3',
      name: 'Forever 21 ',
      imageUrl: 'assets/image3.jpg',
      price: 35.0,
      categoryId: '1',
      colors: ['Green', 'Blue'],
      sizes:  ['XS', 'S', 'M', 'L', 'XL'],
    ),
    Product(
      id: '4',
      name: 'Eden Park white Tops& T-Shirts',
      imageUrl: 'assets/image4.jpg',
      price: 75.0,
      categoryId: '1',
      colors: ['White', 'Black'],
      sizes:  ['XS', 'S', 'M', 'L', 'XL'],
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
      categoryId: '1',
      colors: ['White', 'Black', 'Gray'],
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
    ),
  ];

@override
Future<List<Product>> getProductsByCategory(String categoryId) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return _mockProducts;
}

  @override
  Future<List<Product>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (query.isEmpty) return _mockProducts;
    return _mockProducts
        .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProducts;
  }

  Future<List<ProductCategory>> getCategories() {
    throw UnimplementedError();
  }
}