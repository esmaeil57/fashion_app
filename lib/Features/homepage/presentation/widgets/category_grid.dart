import 'package:flutter/material.dart';
import '../../domain/entities/product_category.dart';

class CategoryGrid extends StatelessWidget {
  final List<ProductCategory> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
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
                    child: CategoryItem(category: row[index]),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final ProductCategory category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(
            child: Image.asset(category.iconPath, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(
            category.name,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
