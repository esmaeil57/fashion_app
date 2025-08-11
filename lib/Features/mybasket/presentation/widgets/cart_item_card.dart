import 'package:flutter/material.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';
import 'package:fashion/core/common_widgets/smart_image.dart';
import '../../domain/entities/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.grayLight,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SmartImage(
                      imageUrl: item.imageUrl,
                      width: 130,
                      height: 130,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        item.productName,
                        style: AppStyles.styleMedium16(context).copyWith(
                          color: AppColors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Category
                      Text(
                        item.categoryName.toUpperCase(),
                        style: AppStyles.styleRegular12(context).copyWith(
                          color: AppColors.gray,
                          letterSpacing: 0.5,
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Size and Color
                      Row(
                        children: [
                          Text(
                            'Size: ${item.selectedSize}',
                            style: AppStyles.styleRegular14(context).copyWith(
                              color: AppColors.gray,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Color: ${item.selectedColor}',
                            style: AppStyles.styleRegular14(context).copyWith(
                              color: AppColors.gray,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Price and Quantity
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (item.isOnSale) ...[
                                Text(
                                  '${item.salePrice!.toInt()} EGP',
                                  style: AppStyles.styleBold16(context).copyWith(
                                    color: AppColors.red,
                                  ),
                                ),
                                Text(
                                  '${item.price.toInt()} EGP',
                                  style: AppStyles.styleRegular14(context).copyWith(
                                    color: AppColors.gray,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ] else
                                Text(
                                  '${item.price.toInt()} EGP',
                                  style: AppStyles.styleBold16(context).copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                            ],
                          ),
                          
                          // Quantity Controls
                          _buildQuantityControls(context),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Remove Button
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.red,
                    size: 24,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControls(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrease Button
          InkWell(
            onTap: () {
              if (item.quantity > 1) {
                onQuantityChanged(item.quantity - 1);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.remove,
                size: 16,
                color: item.quantity > 1 ? AppColors.black : AppColors.gray,
              ),
            ),
          ),
          
          // Quantity
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              '${item.quantity}',
              style: AppStyles.styleMedium16(context).copyWith(
                color: AppColors.black,
              ),
            ),
          ),
          
          // Increase Button
          InkWell(
            onTap: () => onQuantityChanged(item.quantity + 1),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.add,
                size: 16,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}