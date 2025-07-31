import 'package:flutter/material.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';
import 'package:fashion/features/products/domain/entities/product.dart';

class DescriptionSection extends StatelessWidget {
  final Product product;

  const DescriptionSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Product ShortDescription', style: AppStyles.styleMedium16(context)),
        const SizedBox(height: 12),
        Text('Product Full Description', style: AppStyles.styleMedium16(context)),
        const SizedBox(height: 8),
        Text(
          product.description.isNotEmpty
              ? product.description
              : 'Core Accessories Hats Beanie Knit',
          style: AppStyles.styleRegular14(context).copyWith(
            color: AppColors.gray,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
