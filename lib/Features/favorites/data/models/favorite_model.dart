import 'package:hive/hive.dart';
import '../../domain/entities/favorite.dart';
part 'favorite_model.g.dart';

@HiveType(typeId: 1)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String productId;

  @HiveField(2)
  final String productName;

  @HiveField(3)
  final String productImage;

  @HiveField(4)
  final double productPrice;

  @HiveField(5)
  final double? salePrice;

  @HiveField(6)
  final bool isOnSale;

  @HiveField(7)
  final String categoryName;

  @HiveField(8)
  final DateTime addedAt;

  FavoriteModel({
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

  // Convert to domain entity
  Favorite toEntity() {
    return Favorite(
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

  // Create from domain entity
  static FavoriteModel fromEntity(Favorite favorite) {
    return FavoriteModel(
      id: favorite.id,
      productId: favorite.productId,
      productName: favorite.productName,
      productImage: favorite.productImage,
      productPrice: favorite.productPrice,
      salePrice: favorite.salePrice,
      isOnSale: favorite.isOnSale,
      categoryName: favorite.categoryName,
      addedAt: favorite.addedAt,
    );
  }
}