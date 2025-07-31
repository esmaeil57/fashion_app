import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';
import 'package:fashion/features/products/domain/entities/product.dart';
import 'package:fashion/features/products/presentation/cubit/product_cubit.dart';

class BottomActions extends StatelessWidget {
  final Product product;

  const BottomActions({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  context.read<ProductCubit>().toggleCart(product.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        product.isAddedToCart ? 'Removed from cart' : 'Added to cart',
                      ),
                      backgroundColor: AppColors.primary,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Select Color and size',
                  style: AppStyles.styleMedium16(context).copyWith(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
