class CartItem {
  final String productId;
  final String productName;
  final String imageUrl;
  final double price;
  final double? salePrice;
  final String selectedSize;
  final String selectedColor;
  final int quantity;
  final DateTime addedAt;
  final String categoryName;
  final List<String> availableSizes;
  final List<String> availableColors;
  final bool isOnSale;

  const CartItem({
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
  });

  double get effectivePrice => isOnSale && salePrice != null ? salePrice! : price;
  double get totalPrice => effectivePrice * quantity;

  CartItem copyWith({
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
    return CartItem(
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem &&
        other.productId == productId &&
        other.selectedSize == selectedSize &&
        other.selectedColor == selectedColor;
  }

  @override
  int get hashCode => Object.hash(productId, selectedSize, selectedColor);
}