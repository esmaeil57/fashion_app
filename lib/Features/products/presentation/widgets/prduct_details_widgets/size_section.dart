import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';
import 'package:fashion/features/products/presentation/cubit/product_cubit.dart';
import 'package:fashion/features/products/presentation/cubit/product_state.dart';

class SizeSection extends StatelessWidget {
  final List<String> sizes;

  const SizeSection({super.key, required this.sizes});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final selectedSize = (state is ProductLoaded) ? state.selectedSize : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sizes:', style: AppStyles.styleMedium16(context)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: sizes.map((size) {
                final isSelected = selectedSize == size;

                return GestureDetector(
                  onTap: () => context.read<ProductCubit>().selectSize(size),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : AppColors.white,
                      border: Border.all(
                        color: isSelected ? Colors.red : AppColors.borderColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      size,
                      style: AppStyles.styleRegular14(context).copyWith(
                        color: isSelected ? AppColors.white : AppColors.black,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
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
}