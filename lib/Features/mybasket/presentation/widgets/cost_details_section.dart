import 'package:flutter/material.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';
import '../cubit/cart_state.dart';

class CostDetailsSection extends StatelessWidget {
  final CartLoaded state;

  const CostDetailsSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.gray.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cost Details',
                  style: AppStyles.styleBold16(
                    context,
                  ).copyWith(color: AppColors.black),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColors.black),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Cost breakdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _buildCostRow(
                  context,
                  'Subtotal',
                  '${state.subtotal.toStringAsFixed(2)} EGP',
                ),
                const SizedBox(height: 12),
                _buildCostRow(
                  context,
                  'Shipping',
                  '${state.shipping.toStringAsFixed(2)} EGP',
                ),
                _buildCostRow(
                  context,
                  'Shipping',
                  '${state.shipping.toStringAsFixed(2)} EGP',
                ),
                const SizedBox(height: 12),
                _buildCostRow(
                  context,
                  'Tax',
                  '${state.tax.toStringAsFixed(2)} EGP',
                ),
                const SizedBox(height: 12),
                if (state.discount > 0)
                  Column(
                    children: [
                      _buildCostRow(
                        context,
                        'Discount',
                        '-${state.discount.toStringAsFixed(2)} EGP',
                        isDiscount: true,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),

                // Divider
                const Divider(thickness: 1, color: AppColors.borderColor),

                const SizedBox(height: 12),

                // Final Total
                _buildCostRow(
                  context,
                  'Final Total',
                  '${state.total.toStringAsFixed(2)} EGP',
                  isFinal: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Confirm Payment Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to payment confirmation or checkout
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Payment functionality coming soon'),
                      backgroundColor: AppColors.redAccent,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.redAccent,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'CONFIRM PAYMENT',
                  style: AppStyles.styleMedium16(
                    context,
                  ).copyWith(color: AppColors.white, letterSpacing: 0.5),
                ),
              ),
            ),
          ),

          // Safe area padding
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildCostRow(
    BuildContext context,
    String label,
    String value, {
    bool isDiscount = false,
    bool isFinal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:
              isFinal
                  ? AppStyles.styleBold16(
                    context,
                  ).copyWith(color: AppColors.black)
                  : AppStyles.styleRegular14(
                    context,
                  ).copyWith(color: AppColors.gray),
        ),
        Text(
          value,
          style:
              isFinal
                  ? AppStyles.styleBold16(
                    context,
                  ).copyWith(color: AppColors.black)
                  : isDiscount
                  ? AppStyles.styleRegular14(
                    context,
                  ).copyWith(color: AppColors.red)
                  : AppStyles.styleRegular14(
                    context,
                  ).copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
