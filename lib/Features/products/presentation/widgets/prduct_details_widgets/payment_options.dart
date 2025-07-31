import 'package:flutter/material.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';

class PaymentOptions extends StatelessWidget {
  const PaymentOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Options', style: AppStyles.styleMedium16(context)),
        const SizedBox(height: 12),
        _buildOption(context, Icons.money, 'Paying Cash on Delivery', Colors.orange),
        const SizedBox(height: 8),
        _buildOption(context, Icons.credit_card, 'Card Payment', Colors.blue),
      ],
    );
  }

  Widget _buildOption(BuildContext context, IconData icon, String title, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Text(title, style: AppStyles.styleRegular14(context)),
        ],
      ),
    );
  }
}