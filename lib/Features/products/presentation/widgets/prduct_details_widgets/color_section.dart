import 'package:flutter/material.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';

class ColorSection extends StatelessWidget {
  const ColorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Colors:', style: AppStyles.styleMedium16(context)),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.gray.withOpacity(0.3),
                  width: 1,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
