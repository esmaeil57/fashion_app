import 'package:flutter/material.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.grayLight,
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              size: 60,
              color: AppColors.gray,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Your cart is empty',
            style: AppStyles.styleBold20(
              context,
            ).copyWith(color: AppColors.black),
          ),

          const SizedBox(height: 8),

          Text(
            'Add some products to get started',
            style: AppStyles.styleRegular14(
              context,
            ).copyWith(color: AppColors.gray),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
