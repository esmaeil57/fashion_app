import 'package:fashion/core/common_widgets/shimmer_widget.dart';
import 'package:fashion/features/favorites/presentation/cubit/favorite_cubit.dart';
import 'package:fashion/features/favorites/presentation/cubit/favorite_state.dart';
import 'package:fashion/features/products/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/features/products/data/models/product_model.dart';
import 'package:fashion/features/products/presentation/widgets/product_quick_review.dart';
import 'package:fashion/core/dependency_injection/injector.dart';
import '../../domain/entities/product.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final bool isGridView;
  final bool isLoading;

  const ProductCard({
    super.key,
    required this.product,
    this.isGridView = true,
    this.isLoading = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();
  bool _isFavorite = false;
  bool _isLoadingFavorite = true;
  FavoritesCubit  _favoritesCubit = injector<FavoritesCubit>();
  
  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  void _checkFavoriteStatus() async {
    if (!mounted) return;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return _buildShimmerCard();
    }

    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        final isInCart = _getProductFromState(state)?.isAddedToCart ?? false;

        return BlocProvider.value(
          value: _favoritesCubit,
          child: BlocListener<FavoritesCubit, FavoritesState>(
            listener: (context, favState) {
              if (favState is FavoriteToggleSuccess) {
                // Update local state immediately for this specific product
                setState(() {
                  _isFavorite = favState.isAdded;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      favState.isAdded
                          ? '${favState.productName} added to favorites'
                          : '${favState.productName} removed from favorites',
                    ),
                    backgroundColor:
                        favState.isAdded ? Colors.green : Colors.orange,
                    duration: const Duration(seconds: 2),
                  ),
                );
              } else if (favState is FavoritesLoaded) {
                // Check if this product's favorite status has changed
                final isCurrentlyFavorite = favState.favoriteProductIds
                    .contains(widget.product.id);
                if (_isFavorite != isCurrentlyFavorite) {
                  setState(() {
                    _isFavorite = isCurrentlyFavorite;
                    _isLoadingFavorite = false;
                  });
                }
              }
            },
            child: GestureDetector(
              onTap: () => _navigateToProductDetails(context),
              child:
                  widget.isGridView
                      ? _buildGridCard(context, _isFavorite, isInCart)
                      : _buildListCard(context, _isFavorite, isInCart),
            ),
          ),
        );
      },
    );
  }

  void _navigateToProductDetails(BuildContext context) async {
    // Navigate to product details and wait for result
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(product: widget.product),
      ),
    );
    // Refresh favorite status when returning from product details
    _checkFavoriteStatus();
  }

  Product? _getProductFromState(ProductState state) {
    if (state is ProductLoaded) {
      return state.products.firstWhere(
        (p) => p.id == widget.product.id,
        orElse:
            () =>
                widget.product is ProductModel
                    ? widget.product as ProductModel
                    : ProductModel(
                      id: widget.product.id,
                      name: widget.product.name,
                      imageUrls: widget.product.imageUrls,
                      price: widget.product.price,
                      categoryId: widget.product.categoryId,
                      categoryName: widget.product.categoryName,
                    ),
      );
    }
    return null;
  }

  Widget _buildShimmerCard() {
    return Container(
      height: widget.isGridView ? 500 : 420,
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: ShimmerWidget(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Container(
            height: 20,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ShimmerWidget(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(
                    child: Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ShimmerWidget(
                    child: Container(
                      width: 80,
                      height: 14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridCard(BuildContext context, bool isFavorite, bool isInCart) {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _buildImageSection(context, isFavorite, isInCart),
          ),
          _buildProgressIndicator(),
          Expanded(flex: 1, child: _buildProductInfo()),
        ],
      ),
    );
  }

  Widget _buildListCard(BuildContext context, bool isFavorite, bool isInCart) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 450,
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: _buildImageSection(context, isFavorite, isInCart),
          ),
          _buildProgressIndicator(),
          Expanded(flex: 1, child: _buildProductInfo(isListView: true)),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    if (widget.product.imageUrls.length <= 1) {
      return const SizedBox(height: 20);
    }

    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.product.imageUrls.length > 6
              ? 6
              : widget.product.imageUrls.length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: index == _currentImageIndex ? 20 : 15,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color:
                  index == _currentImageIndex ? Colors.red : Colors.grey[300],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(
    BuildContext context,
    bool isFavorite,
    bool isInCart,
  ) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            color: Colors.grey[100],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: _buildImageCarousel(),
          ),
        ),
        // Favorite button with loading state
        Positioned(
          top: 12,
          right: 12,
          child:
              _isLoadingFavorite
                  ? Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  )
                  : _buildIconButton(
                    Icons.favorite,
                    Icons.favorite_border,
                    isFavorite,
                    () {
                      if (!_isLoadingFavorite) {
                        _favoritesCubit.toggleFavorite(widget.product);
                      }
                    },
                    backgroundColor: Colors.white,
                  ),
        ),
        // Cart button
        Positioned(
          bottom: 12,
          right: 12,
          child: _buildIconButton(
            Icons.shopping_bag,
            Icons.shopping_bag_outlined,
            isInCart,
            () => _showQuickReview(context),
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo({bool isListView = false}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              widget.product.name.length > 20
                  ? '${widget.product.name.substring(0, 15)}...'
                  : widget.product.name,
              style: TextStyle(
                fontSize: isListView ? 16 : 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          _buildPriceSection(isListView),
        ],
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
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        icon: Icon(
          isActive ? activeIcon : inactiveIcon,
          color: isActive ? Colors.red : Colors.grey[600],
          size: 22,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildPriceSection(bool isListView) {
    return Row(
      children: [
        if (widget.product.isOnSale) ...[
          Text(
            '${widget.product.salePrice?.toInt() ?? widget.product.price.toInt()} EGP',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isListView ? 16 : 14,
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${widget.product.price.toInt()} EGP',
            style: TextStyle(
              fontSize: isListView ? 14 : 12,
              color: Colors.grey[600],
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ] else
          Text(
            '${widget.product.price.toInt()} EGP',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isListView ? 16 : 14,
              color: Colors.black87,
            ),
          ),
      ],
    );
  }

  Widget _buildImageCarousel() {
    if (widget.product.imageUrls.isEmpty) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[200],
        child: const Icon(Icons.image, size: 50, color: Colors.grey),
      );
    }

    return PageView.builder(
      controller: _pageController,
      itemCount:
          widget.product.imageUrls.length > 6
              ? 6
              : widget.product.imageUrls.length,
      onPageChanged: (index) {
        setState(() {
          _currentImageIndex = index;
        });
      },
      itemBuilder: (context, index) {
        return Image.network(
          widget.product.imageUrls[index],
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Container(
              color: Colors.grey[200],
              child: Center(
                child: ShimmerWidget(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            );
          },
          errorBuilder:
              (context, error, stackTrace) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.image, size: 50, color: Colors.grey),
              ),
        );
      },
    );
  }

  void _showQuickReview(BuildContext context) {
    final cubit = context.read<ProductCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: BlocProvider.value(
              value: cubit,
              child: ProductQuickReview(product: widget.product),
            ),
          ),
    ).whenComplete(() {
      context.read<ProductCubit>().clearSelections();
    });
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
