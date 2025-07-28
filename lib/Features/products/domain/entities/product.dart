class Product {
  final String id;
  final String name;
  final List<String> imageUrls; 
  final double price;
  final String categoryId;
  final String categoryName;
  final bool isFavorite;
  final bool isAddedToCart;
  final List<String> colors;
  final List<String> sizes;
  final String description;
  final String sku; 
  final bool inStock;
  final int stockQuantity;
  final double? salePrice;
  final String status;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrls,
    required this.price,
    required this.categoryId,
    required this.categoryName,
    this.isFavorite = false,
    this.isAddedToCart = false,
    this.colors = const [],
    this.sizes = const [],
    this.description = '',
    this.sku = '',
    this.inStock = true,
    this.stockQuantity = 0,
    this.salePrice,
    this.status = 'publish',
  });

  // Helper method to get the effective price (sale price if available, otherwise regular price)
  double get effectivePrice => salePrice ?? price;

  // Helper method to check if product is on sale
  bool get isOnSale => salePrice != null && salePrice! < price;

  // Copy with method for state management
  Product copyWith({
    String? id,
    String? name,
    List<String>? imageUrls,
    double? price,
    String? categoryId,
    String? categoryName,
    bool? isFavorite,
    bool? isAddedToCart,
    List<String>? colors,
    List<String>? sizes,
    String? description,
    String? sku,
    bool? inStock,
    int? stockQuantity,
    double? salePrice,
    String? status,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrls: imageUrls ?? this.imageUrls,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      isFavorite: isFavorite ?? this.isFavorite,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      description: description ?? this.description,
      sku: sku ?? this.sku,
      inStock: inStock ?? this.inStock,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      salePrice: salePrice ?? this.salePrice,
      status: status ?? this.status,
    );
  }
}