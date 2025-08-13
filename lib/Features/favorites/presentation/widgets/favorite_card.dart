import 'package:flutter/material.dart';
import 'package:fashion/core/shared_widgets/smart_image.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import '../../domain/entities/favorite.dart';

class FavoriteCard extends StatelessWidget {
  final Favorite favorite;
  final VoidCallback onRemove;

  const FavoriteCard({
    super.key,
    required this.favorite,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with heart icon
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: SmartImage(
                      imageUrl: favorite.productImage,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                // Remove button
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => _showRemoveDialog(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        size: 24,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Product info section
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Product name
                  Flexible(
                    child: Text(
                      favorite.productName.length > 25
                          ? '${favorite.productName.substring(0, 25)}...'
                          : favorite.productName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Price section
                  Row(
                    children: [
                      if (favorite.isOnSale && favorite.salePrice != null) ...[
                        Text(
                          '${favorite.salePrice!.toInt()} EGP',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.red,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${favorite.productPrice.toInt()} EGP',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.gray,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ] else
                        Text(
                          '${favorite.productPrice.toInt()} EGP',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(top: 8),
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.black,
                side: const BorderSide(color: AppColors.borderLightGrayColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {},
              child: const Text(
                'ADD TO CART',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
                    ),
          ),
        ],
      ),
    );
  }

  void _showRemoveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Remove from Favorites'),
            content: Text('Remove "${favorite.productName}" from favorites?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  onRemove();
                  Navigator.pop(dialogContext);
                },
                style: TextButton.styleFrom(foregroundColor: AppColors.red),
                child: const Text('Remove'),
              ),
            ],
          ),
    );
  }
}