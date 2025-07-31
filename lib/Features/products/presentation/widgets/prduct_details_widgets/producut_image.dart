import 'package:flutter/material.dart';
import 'package:fashion/core/common_widgets/smart_image.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';

class ProductImages extends StatelessWidget {
  final List<String> images;
  final int currentIndex;
  final PageController controller;
  final void Function(int) onPageChanged;

  const ProductImages({
    super.key,
    required this.images,
    required this.currentIndex,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final imageList = images.isNotEmpty ? images : ['assets/images/placeholder.png'];

    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            onPageChanged: onPageChanged,
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SmartImage(
                    imageUrl: imageList[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 400,
                  ),
                ),
              );
            },
          ),
          if (imageList.length > 1)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imageList.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentIndex == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? AppColors.black
                          : AppColors.gray.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
