import 'package:fashion/features/products/domain/entities/product.dart';
import 'package:fashion/features/products_details/presentation/widgets/prduct_details_widgets/product_id.dart';
import 'package:flutter/material.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';

class ProductHeader extends StatelessWidget {
  final Product product;

  const ProductHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          Text(
            'EGP ${product.price}',
            style: AppStyles.styleBold20(context),
          ),
        Spacer(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name, style: AppStyles.styleMedium18(context)),
              SizedBox(height: 4),
              ProductId(productId: product.id.toString()),
            ],
          ),
        ),
    ]);
  }
}
