import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/features/products/domain/entities/product.dart';
import 'package:fashion/features/products/presentation/cubit/product_cubit.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/bottom_actions.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/color_section.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/description_section.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/payment_options.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/product_details_info.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/product_header.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/producut_image.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/return_policy.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/size_section.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: ProductImages(
              images: widget.product.imageUrls,
              currentIndex: _currentImageIndex,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentImageIndex = index);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductHeader(product: widget.product),
                  const Divider(thickness: 2, color: AppColors.borderColor),
                  const SizedBox(height: 16),
                  if (widget.product.sizes.isNotEmpty)
                    SizeSection(sizes: widget.product.sizes),
                  const SizedBox(height: 20),
                  if (widget.product.colors.isNotEmpty)
                    const ColorSection(),
                  const SizedBox(height: 20),
                  DescriptionSection(product: widget.product),
                  const SizedBox(height: 20),
                  ProductDetailsInfo(product: widget.product),
                  const SizedBox(height: 20),
                  const ReturnPolicy(),
                  const SizedBox(height: 20),
                  const PaymentOptions(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomActions(product: widget.product),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.black, size: 20),
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.read<ProductCubit>().toggleFavorite(widget.product.id);
          },
          icon: Icon(
            widget.product.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: widget.product.isFavorite ? AppColors.red : AppColors.gray,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.share_outlined, color: AppColors.black),
        ),
      ],
    );
  }
}
