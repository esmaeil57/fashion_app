import 'package:hive/hive.dart';
import '../../domain/entities/cart_item.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel extends CartItem {
  @override
  @HiveField(0)
  final String productId;


  @override
  @HiveField(1)
  final String productName;

  @override
  @HiveField(2)
  final String imageUrl;

  @override
  @HiveField(3)
  final double price;

  @override
  @HiveField(4)
  final double? salePrice;

  @override
  @HiveField(5)
  final String selectedSize;

  @override
  @HiveField(6)
  final String selectedColor;

  @override
  @HiveField(7)
  final int quantity;

  @override
  @HiveField(8)
  final DateTime addedAt;

  @override
  @HiveField(9)
  final String categoryName;

  @override
  @HiveField(10)
  final List<String> availableSizes;

  @override
  @HiveField(11)
  final List<String> availableColors;

  @override
  @HiveField(12)
  final bool isOnSale;

  const CartItemModel({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    this.salePrice,
    required this.selectedSize,
    required this.selectedColor,
    required this.quantity,
    required this.addedAt,
    required this.categoryName,
    required this.availableSizes,
    required this.availableColors,
    required this.isOnSale,
  }) : super(
          productId: productId,
          productName: productName,
          imageUrl: imageUrl,
          price: price,
          salePrice: salePrice,
          selectedSize: selectedSize,
          selectedColor: selectedColor,
          quantity: quantity,
          addedAt: addedAt,
          categoryName: categoryName,
          availableSizes: availableSizes,
          availableColors: availableColors,
          isOnSale: isOnSale,
        );

  factory CartItemModel.fromEntity(CartItem cartItem) {
    return CartItemModel(
      productId: cartItem.productId,
      productName: cartItem.productName,
      imageUrl: cartItem.imageUrl,
      price: cartItem.price,
      salePrice: cartItem.salePrice,
      selectedSize: cartItem.selectedSize,
      selectedColor: cartItem.selectedColor,
      quantity: cartItem.quantity,
      addedAt: cartItem.addedAt,
      categoryName: cartItem.categoryName,
      availableSizes: cartItem.availableSizes,
      availableColors: cartItem.availableColors,
      isOnSale: cartItem.isOnSale,
    );
  }

  factory CartItemModel.fromProduct({
    required String productId,
    required String productName,
    required String imageUrl,
    required double price,
    double? salePrice,
    required String selectedSize,
    required String selectedColor,
    required String categoryName,
    required List<String> availableSizes,
    required List<String> availableColors,
    required bool isOnSale,
    int quantity = 1,
  }) {
    return CartItemModel(
      productId: productId,
      productName: productName,
      imageUrl: imageUrl,
      price: price,
      salePrice: salePrice,
      selectedSize: selectedSize,
      selectedColor: selectedColor,
      quantity: quantity,
      addedAt: DateTime.now(),
      categoryName: categoryName,
      availableSizes: availableSizes,
      availableColors: availableColors,
      isOnSale: isOnSale,
    );
  }

  @override
  CartItemModel copyWith({
    String? productId,
    String? productName,
    String? imageUrl,
    double? price,
    double? salePrice,
    String? selectedSize,
    String? selectedColor,
    int? quantity,
    DateTime? addedAt,
    String? categoryName,
    List<String>? availableSizes,
    List<String>? availableColors,
    bool? isOnSale,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
      categoryName: categoryName ?? this.categoryName,
      availableSizes: availableSizes ?? this.availableSizes,
      availableColors: availableColors ?? this.availableColors,
      isOnSale: isOnSale ?? this.isOnSale,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'imageUrl': imageUrl,
      'price': price,
      'salePrice': salePrice,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
      'categoryName': categoryName,
      'availableSizes': availableSizes,
      'availableColors': availableColors,
      'isOnSale': isOnSale,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      productName: json['productName'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      salePrice: json['salePrice']?.toDouble(),
      selectedSize: json['selectedSize'],
      selectedColor: json['selectedColor'],
      quantity: json['quantity'],
      addedAt: DateTime.parse(json['addedAt']),
      categoryName: json['categoryName'],
      availableSizes: List<String>.from(json['availableSizes']),
      availableColors: List<String>.from(json['availableColors']),
      isOnSale: json['isOnSale'],
    );
  }
}