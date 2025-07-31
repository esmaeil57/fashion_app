import 'package:flutter/material.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';

class ReturnPolicy extends StatelessWidget {
  const ReturnPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(      
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.refresh, color: AppColors.gray, size: 20),
          const SizedBox(width: 12),
          Text(
            'Return within 30 Days',
            style: AppStyles.styleRegular14(context).copyWith(color: AppColors.gray , fontSize: 16,),
          ),
        ],
      ),
    );
  }
}