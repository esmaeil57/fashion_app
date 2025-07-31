import 'package:flutter/material.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/features/products/domain/entities/product.dart';

class ProductDetailsInfo extends StatelessWidget {
  final Product product;

  const ProductDetailsInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDetailRow(context, 'Category', product.categoryName),
        _buildDetailRow(context, 'SKU', product.sku.isNotEmpty ? product.sku : 'N/A'),
        _buildDetailRow(context, 'Stock', product.inStock ? 'In Stock' : 'Out of Stock'),
        if (product.stockQuantity > 0)
          _buildDetailRow(context, 'Quantity', '${product.stockQuantity}')
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: AppStyles.styleRegular14(context).copyWith(color: AppColors.gray),
            ),
          ),
          Expanded(
            child: Text(value, style: AppStyles.styleRegular14(context)),
          ),
        ],
      ),
    );
  }
}
