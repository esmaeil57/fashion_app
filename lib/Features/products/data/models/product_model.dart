import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.imageUrls,
    required super.price,
    required super.categoryId,
    required super.categoryName,
    super.isFavorite,
    super.isAddedToCart,
    super.colors,
    super.sizes,
    super.description,
    super.sku,
    super.inStock,
    super.stockQuantity,
    super.salePrice,
    super.status,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Extract image URLs
    List<String> imageUrls = [];
    if (json['images'] != null && json['images'] is List) {
      imageUrls = (json['images'] as List)
          .map((image) => image['src'] as String? ?? '')
          .where((url) => url.isNotEmpty)
          .toList();
    }

    // Extract colors from attributes
    List<String> colors = [];
    if (json['attributes'] != null && json['attributes'] is List) {
      final colorAttribute = (json['attributes'] as List).firstWhere(
        (attr) => attr['name']?.toString().toLowerCase().contains('color') == true ||
                  attr['name']?.toString().toLowerCase().contains('colour') == true,
        orElse: () => null,
      );
      if (colorAttribute != null && colorAttribute['options'] != null) {
        colors = (colorAttribute['options'] as List)
            .map((option) => option.toString())
            .toList();
      }
    }

    // Extract sizes from attributes
    List<String> sizes = [];
    if (json['attributes'] != null && json['attributes'] is List) {
      final sizeAttribute = (json['attributes'] as List).firstWhere(
        (attr) => attr['name']?.toString().toLowerCase().contains('size') == true,
        orElse: () => null,
      );
      if (sizeAttribute != null && sizeAttribute['options'] != null) {
        sizes = (sizeAttribute['options'] as List)
            .map((option) => option.toString())
            .toList();
      }
    }

    // Extract category information
    String categoryId = '';
    String categoryName = '';
    if (json['categories'] != null && json['categories'] is List && (json['categories'] as List).isNotEmpty) {
      final firstCategory = (json['categories'] as List).first;
      categoryId = firstCategory['id']?.toString() ?? '';
      categoryName = firstCategory['name']?.toString() ?? '';
    }

    // Parse prices
    double regularPrice = 0.0;
    double? salePrice;
    
    try {
      regularPrice = double.tryParse(json['regular_price']?.toString() ?? '0') ?? 0.0;
      final salePriceStr = json['sale_price']?.toString();
      if (salePriceStr != null && salePriceStr.isNotEmpty) {
        salePrice = double.tryParse(salePriceStr);
      }
    } catch (e) {
      regularPrice = 0.0;
    }

    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      imageUrls: imageUrls,
      price: regularPrice,
      salePrice: salePrice,
      categoryId: categoryId,
      categoryName: categoryName,
      colors: colors,
      sizes: sizes,
      description: json['description']?.toString() ?? '',
      sku: json['sku']?.toString() ?? '',
      inStock: json['in_stock'] ?? true,
      stockQuantity: json['stock_quantity'] ?? 0,
      status: json['status']?.toString() ?? 'publish',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'images': imageUrls.map((url) => {'src': url}).toList(),
      'regular_price': price.toString(),
      'sale_price': salePrice?.toString(),
      'categories': [
        {
          'id': categoryId,
          'name': categoryName,
        }
      ],
      'attributes': [
        if (colors.isNotEmpty)
          {
            'name': 'Color',
            'options': colors,
          },
        if (sizes.isNotEmpty)
          {
            'name': 'Size',
            'options': sizes,
          },
      ],
      'description': description,
      'sku': sku,
      'in_stock': inStock,
      'stock_quantity': stockQuantity,
      'status': status,
    };
  }
}