import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/product_id.dart';
import 'package:flutter/material.dart';
import 'package:fashion/features/products/domain/entities/product.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';

class ProductHeader extends StatelessWidget {
  final Product product;

  const ProductHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (product.isOnSale) ...[
          Text(
            'EGP ${product.salePrice!.toStringAsFixed(2)}',
            style: AppStyles.styleBold16(context).copyWith(color: AppColors.red),
          ),
          const SizedBox(width: 8),
          Text(
            'EGP ${product.price.toStringAsFixed(2)}',
            style: AppStyles.styleRegular16(context).copyWith(
              color: AppColors.gray,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ] else ...[
          Text(
            'EGP ${product.price.toStringAsFixed(2)}',
            style: AppStyles.styleBold20(context),
          ),
        ],
        Spacer(),
      Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.name, style: AppStyles.styleMedium18(context)),
          SizedBox(height: 4,),
          ProductId(productId: product.id),
        ],
      )),
    
      ],
    );
  }
}
