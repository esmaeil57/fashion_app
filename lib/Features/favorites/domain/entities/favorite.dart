import 'package:fashion/features/favorites/data/models/favorite_model.dart';

class Favorite {
  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final double? salePrice;
  final bool isOnSale;
  final String categoryName;
  final DateTime addedAt;

  const Favorite({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    this.salePrice,
    required this.isOnSale,
    required this.categoryName,
    required this.addedAt,
  });

  double get effectivePrice => isOnSale && salePrice != null ? salePrice! : productPrice;

  // Convert from Product entity to Favorite entity
  static Favorite fromProduct({
    required String productId,
    required String productName,
    required String productImage,
    required double productPrice,
    double? salePrice,
    required bool isOnSale,
    required String categoryName,
  }) {
    return Favorite(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      productId: productId,
      productName: productName,
      productImage: productImage,
      productPrice: productPrice,
      salePrice: salePrice,
      isOnSale: isOnSale,
      categoryName: categoryName,
      addedAt: DateTime.now(),
    );
  }

  FavoriteModel toModel() {
    return FavoriteModel(
      id: id,
      productId: productId,
      productName: productName,
      productImage: productImage,
      productPrice: productPrice,
      salePrice: salePrice,
      isOnSale: isOnSale,
      categoryName: categoryName,
      addedAt: addedAt,
    );
  }
}