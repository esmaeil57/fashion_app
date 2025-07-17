import 'package:flutter/material.dart';
import 'product_banner_item.dart'; // 👈 Import the new widget

class ProductBanner extends StatelessWidget {
  const ProductBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> banners = [
      {
        'image': 'https://via.placeholder.com/200x200',
        'title': 'الموسم الجديد',
        'subtitle': 'أطفال',
      },
      {
        'image': 'https://via.placeholder.com/200x200',
        'title': 'الموسم الجديد',
        'subtitle': 'دينم',
        'extra': 'نساء رجال',
      },
        {
        'image': 'https://via.placeholder.com/200x200',
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