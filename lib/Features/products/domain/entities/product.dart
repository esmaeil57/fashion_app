class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String categoryId;
  final bool isFavorite;
  final bool isAddedToCart;
  final List<String> colors;
  final List<String> sizes;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.categoryId,
    this.isFavorite = false,
    this.isAddedToCart = false,
    this.colors = const [],
    this.sizes = const [],
  });
}
