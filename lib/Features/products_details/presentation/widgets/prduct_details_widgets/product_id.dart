import 'package:flutter/material.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';

class ProductId extends StatelessWidget {
  final String productId;

  const ProductId({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Text(
      productId,
      style: AppStyles.styleRegular14(context).copyWith(color: AppColors.gray),
    );
  }
}
