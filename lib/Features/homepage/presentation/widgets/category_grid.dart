import 'package:flutter/material.dart';
import '../../domain/entities/product_category.dart';
import '../../../products/presentation/pages/products_page.dart';
import '../../../../core/common_widgets/smart_image.dart';

class CategoryGrid extends StatelessWidget {
  final List<ProductCategory> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return _buildEmptyState();
    }

    // Calculate items per row dynamically (at least 1 to avoid division by zero)
    final int itemsPerRow = (categories.length / 2).ceil().clamp(1, categories.length);

    // Split categories into chunks (rows)
    final List<List<ProductCategory>> rows = [];
    for (int i = 0; i < categories.length; i += itemsPerRow) {
      rows.add(
        categories.sublist(
          i,
          i + itemsPerRow > categories.length
              ? categories.length
              : i + itemsPerRow,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        for (var row in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: row.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CategoryItem(
                      category: row[index],
                      onTap: () => _navigateToProducts(context, row[index]),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 120,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 8),
            Text(
              'لا توجد فئات متاحة',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProducts(BuildContext context, ProductCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsPage(
          categoryId: category.id,
          categoryName: category.name,
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final ProductCategory category;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key, 
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        height: 110,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // Add subtle hover effect
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: SmartImage(
                  imageUrl: category.iconPath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: 'assets/logo.png',
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: SizedBox(
                width: 80,
                child: Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 10, 
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}