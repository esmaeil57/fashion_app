import 'package:flutter/material.dart';
import 'package:fashion/core/shared_widgets/smart_image.dart';

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
      width: double.infinity,
      height: double.infinity,
      child: PageView.builder(
        scrollDirection: Axis.vertical, 
        controller: controller,
        onPageChanged: onPageChanged,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return SmartImage(
            imageUrl: imageList[index],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        },
      ),
    );
  }
}
