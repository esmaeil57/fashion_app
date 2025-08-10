import 'package:fashion/features/favorites/presentation/cubit/favorite_cubit.dart';
import 'package:fashion/features/favorites/presentation/cubit/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/features/products/domain/entities/product.dart';
import 'package:fashion/features/products/presentation/cubit/product_cubit.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/color_section.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/description_section.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/payment_options.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/product_details_info.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/product_header.dart';
import 'package:fashion/features/products/presentation/widgets/prduct_details_widgets/product_image.dart';
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
  final DraggableScrollableController _bottomSheetController = DraggableScrollableController();
  late FavoritesCubit _favoritesCubit;
  bool _isFavorite = false;
  bool _isLoadingFavorite = true;

  @override
  void initState() {
    super.initState();
    _favoritesCubit = injector<FavoritesCubit>();
    _checkFavoriteStatus();
  }

  void _checkFavoriteStatus() async {
    setState(() => _isLoadingFavorite = true);
    final isFav = await _favoritesCubit.checkIsFavorite(widget.product.id);
    if (mounted) {
      setState(() {
        _isFavorite = isFav;
        _isLoadingFavorite = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bottomSheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> limitedImageUrls = widget.product.imageUrls.take(5).toList();
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injector<ProductCubit>()),
        BlocProvider.value(value: _favoritesCubit),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            // Fixed Image Section
            Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Stack(
                children: [
                  ProductImages(
                    images: limitedImageUrls,
                    currentIndex: _currentImageIndex,
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentImageIndex = index);
                    },
                  ),
                  // Vertical Image Indicators
                  if (widget.product.imageUrls.length > 1)
                    Positioned(
                      right: 20,
                      top: 0,
                      bottom: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          limitedImageUrls.length,
                          (index) => GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              width: 8,
                              height: _currentImageIndex == index ? 24 : 8,
                              decoration: BoxDecoration(
                                color: _currentImageIndex == index
                                    ? AppColors.redAccent
                                    : AppColors.gray.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Back button
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                  // Share button
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Share functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Share functionality coming soon'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.share, color: Colors.black),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Sheet
            DraggableScrollableSheet(
              controller: _bottomSheetController,
              initialChildSize: 0.30,
              minChildSize: 0.30,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Drag Handle
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.gray.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      // Scrollable Content
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProductHeader(product: widget.product),
                              const SizedBox(height: 16),
                              const Divider(thickness: 1, color: AppColors.borderColor),
                              const SizedBox(height: 16),
                              if (widget.product.sizes.isNotEmpty)
                                SizeSection(sizes: widget.product.sizes),
                              const SizedBox(height: 20),
                              if (widget.product.colors.isNotEmpty)
                                ColorSection(colors: widget.product.colors),
                              const SizedBox(height: 20),
                              DescriptionSection(product: widget.product),
                              const SizedBox(height: 20),
                              ProductDetailsInfo(product: widget.product),
                              const SizedBox(height: 20),
                              const ReturnPolicy(),
                              const SizedBox(height: 20),
                              const PaymentOptions(),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      // Bottom Actions
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          border: Border(
                            top: BorderSide(color: AppColors.borderColor, width: 0.5),
                          ),
                        ),
                        child: SafeArea(
                          child: Row(
                            children: [
                              // Share Button
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.borderColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // Share functionality
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Share functionality coming soon'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.share_outlined,
                                    color: AppColors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Favorite Button with BlocListener
                              BlocListener<FavoritesCubit, FavoritesState>(
                                listener: (context, state) {
                                  if (state is FavoriteToggleSuccess) {
                                    setState(() {
                                      _isFavorite = state.isAdded;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          state.isAdded
                                              ? '${state.productName} added to favorites'
                                              : '${state.productName} removed from favorites',
                                        ),
                                        backgroundColor: state.isAdded ? Colors.green : Colors.orange,
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  } else if (state is FavoritesError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Error: ${state.message}'),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.borderColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: _isLoadingFavorite
                                      ? Container(
                                          padding: const EdgeInsets.all(12),
                                          child: const CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                                          ),
                                        )
                                      : _buildIconButton(
                                          Icons.favorite,
                                          Icons.favorite_border,
                                          _isFavorite,
                                          () {
                                            if (!_isLoadingFavorite) {
                                              _favoritesCubit.toggleFavorite(widget.product);
                                            }
                                          },
                                          backgroundColor: Colors.white,
                                        ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              
                              // Select Button
                              Expanded(
                                child: BlocBuilder<ProductCubit, dynamic>(
                                  builder: (context, state) {
                                    final hasSelectedSize = state.selectedSize != null;
                                    final hasSelectedColor = state.selectedColor != null;
                                    final canAddToCart = hasSelectedSize || hasSelectedColor || 
                                        (widget.product.sizes.isEmpty && widget.product.colors.isEmpty);

                                    return ElevatedButton(
                                      onPressed: widget.product.inStock ? () {
                                        if (canAddToCart) {
                                          // Add to cart functionality
                                          context.read<ProductCubit>().toggleCart(widget.product.id);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('${widget.product.name} added to cart'),
                                              backgroundColor: Colors.green,
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Please select size and color'),
                                              backgroundColor: Colors.orange,
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      } : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: widget.product.inStock 
                                            ? AppColors.redAccent 
                                            : Colors.grey,
                                        foregroundColor: AppColors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        widget.product.inStock 
                                            ? (canAddToCart ? 'ADD TO CART' : 'Select Color and Size')
                                            : 'OUT OF STOCK',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildIconButton(
    IconData activeIcon,
    IconData inactiveIcon,
    bool isActive,
    VoidCallback onPressed, {
    Color backgroundColor = Colors.white,
  }) {
    return IconButton(
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      icon: Icon(
        isActive ? activeIcon : inactiveIcon,
        color: isActive ? Colors.red : Colors.grey[600],
        size: 25,
      ),
      onPressed: onPressed,
    );
  }
}