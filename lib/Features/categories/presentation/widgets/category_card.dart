import 'package:flutter/material.dart';
import 'package:fashion/core/common_widgets/smart_image.dart';
import '../../../products/presentation/pages/products_page.dart';
import '../../domain/entities/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsPage(
                categoryId: category.id,
                categoryName: category.name,
              ),
            ),
          );
        },
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryImage(),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    category.name,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryImage() {
    // Check if we have a real image URL or just the placeholder
    if (category.imageUrl == 'assets/logo.png' || 
        category.imageUrl.isEmpty ||
        category.imageUrl == 'null') {
      // Use FigLogo for placeholder/default images
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
        ),
        child: Image.asset('assets/logo.png'),
      );
    } else {
      // Use SmartImage for network/asset images
      return SmartImage(
        imageUrl: category.imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        placeholder: 'assets/logo.png', // Fallback to logo
        borderRadius: BorderRadius.circular(8),
      );
    }
  }
}