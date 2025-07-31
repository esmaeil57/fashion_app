import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';
import 'package:fashion/features/products/presentation/cubit/product_cubit.dart';
import 'package:fashion/features/products/presentation/cubit/product_state.dart';

class ColorSection extends StatelessWidget {
  final List<String> colors;

  const ColorSection({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    if (colors.isEmpty) return const SizedBox();

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Colors:',
              style: AppStyles.styleMedium16(context),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: colors.map((color) {
                final index = colors.indexOf(color);
                final isSelected = state.selectedColor == color;

                return GestureDetector(
                  onTap: () => context.read<ProductCubit>().selectColor(color, index),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColors.red : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: _parseColor(color),
                      radius: 16,
                      child: isSelected
                          ? const Icon(Icons.check, color: Colors.white, size: 16)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
  // Enhanced color parser with more color options
  Color _parseColor(String color) {
    switch (color.toLowerCase()) {
      case 'black':
        return AppColors.black;
      case 'red':
        return AppColors.red;
      case 'blue':
        return AppColors.fontColor;
      case 'white':
        return AppColors.white;
      case 'grey':
      case 'gray':
        return AppColors.gray;
      case 'pink':
        return Colors.pink;
      case 'green':
        return AppColors.green;
      case 'yellow':
        return AppColors.yellow;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'brown':
        return Colors.brown;
      case 'navy':
        return const Color(0xFF001f3f);
      case 'beige':
        return const Color(0xFFF5F5DC);
      case 'maroon':
        return const Color(0xFF800000);
      case 'teal':
        return Colors.teal;
      case 'lime':
        return Colors.lime;
      case 'indigo':
        return Colors.indigo;
      case 'cyan':
        return Colors.cyan;
      default:
        return Colors.grey.shade400;
    }
  }
}
