import 'package:flutter/material.dart';
import '../../domain/entities/product_category.dart';

class CategoryGrid extends StatelessWidget {
  final List<ProductCategory> categories;

  const CategoryGrid({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define how many items per row
    const int itemsPerRow = 6;

    // Split categories into chunks (rows)
    final List<List<ProductCategory>> rows = [];
    for (int i = 0; i < categories.length; i += itemsPerRow) {
      rows.add(categories.sublist(
        i,
        i + itemsPerRow > categories.length ? categories.length : i + itemsPerRow,
      ));
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

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration:  BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              category.iconPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 70,
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
