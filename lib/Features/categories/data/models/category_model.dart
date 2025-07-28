import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    print(' Parsing category JSON: $json');
    
  
    String imageUrl = 'assets/logo.png'; // Default fallback
    
    if (json['image'] != null) {
      final imageData = json['image'];
      if (imageData is Map<String, dynamic> && imageData['src'] != null) {
        final srcUrl = imageData['src'].toString();
        if (srcUrl.isNotEmpty && srcUrl != 'null') {
          imageUrl = srcUrl;
        }
      } else if (imageData is String && imageData.isNotEmpty && imageData != 'null') {
        imageUrl = imageData;
      }
    }
    
    print(' Image URL for ${json['name']}: $imageUrl');
    
    return CategoryModel(
      id: json['id']?.toString() ?? '0',
      name: json['name']?.toString() ?? 'Unknown Category',
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': int.tryParse(id) ?? 0,
      'name': name,
      'image': imageUrl != 'assets/logo.png' && imageUrl.isNotEmpty 
          ? {'src': imageUrl} 
          : null,
    };
  }
}
