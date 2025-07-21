import 'package:flutter/material.dart';
import 'product_banner_item.dart';

class ProductBanner extends StatelessWidget {
  const ProductBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> banners = [
      {
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmaeAblPBdnAlPw8LVWljiu9biDh-kyM7YNA&s',
        'title': 'الموسم الجديد',
        'subtitle': 'أطفال',
      },
      {
        'image': 'https://media.alshaya.com/adobe/assets/urn:aaid:aem:c0868e58-b7a4-4d77-b336-31b23545af73/as/aeo-28-05-2025-su25-hero-2Col-loose-jeans-m.jpg?preferwebp=true&width=750&format=jpg',
        'title': 'الموسم الجديد',
        'subtitle': 'دينم',
        'extra': 'نساء رجال',
      },
        {
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa0Nu0sOlaQGfGhmM28nNXMSVGK8U0pDlgJA&s',
        'title': 'عروض الصيف',
        'subtitle': 'تيشيرتات',
        'extra': 'رجال',
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: banners.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final banner = banners[index];
        return ProductBannerItem(
          imageUrl: banner['image'],
          title: banner['title'],
          subtitle: banner['subtitle'],
          extra: banner['extra'],
        );
      },
    );
  }
}