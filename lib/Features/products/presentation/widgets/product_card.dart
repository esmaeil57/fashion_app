import 'package:fashion/features/products/presentation/widgets/product_quick_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isGridView;

  const ProductCard({super.key, required this.product, this.isGridView = true});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        final isFavorite = _isProductFavorite(state, product.id);
        return isGridView
            ? _buildGridCard(context, isFavorite)
            : _buildListCard(context, isFavorite);
      },
    );
  }

  bool _isProductFavorite(ProductState state, String productId) {
    if (state is ProductLoaded) {
      final productInState = state.products.firstWhere(
        (p) => p.id == productId,
        orElse: () => product,
      );
      return productInState.isFavorite;
    }
    return product.isFavorite;
  }

  bool _isProductInCart(ProductState state, String productId) {
    if (state is ProductLoaded) {
      final productInState = state.products.firstWhere(
        (p) => p.id == productId,
        orElse: () => product,
      );
      return productInState.isAddedToCart;
    }
    return false;
  }

  Widget _buildGridCard(BuildContext context, bool isFavorite) {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1, // make it square
                child: _productImage(product.imageUrl, topCornersOnly: false),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Column(
                  children: [
                    BlocBuilder<ProductCubit, ProductState>(
                      builder: (context, state) {
                        final isFavorite = _isProductFavorite(
                          state,
                          product.id,
                        );
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                            size: 20,
                          ),
                          onPressed: () {
                            context.read<ProductCubit>().toggleFavorite(
                              product.id,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    final isAddedToCart = _isProductInCart(state, product.id);
                    return IconButton(
                      icon: Icon(
                        isAddedToCart
                            ? Icons.shopping_bag
                            : Icons.shopping_bag_outlined,
                        color: isAddedToCart ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        final cubit =
                            context
                                .read<
                                  ProductCubit
                                >(); // Get the current cubit instance
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          builder: (bottomSheetContext) {
                            return BlocProvider.value(
                              value: cubit,
                              child: ProductQuickReview(product: product),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              product.name,
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${product.price.toInt()} EGP',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildListCard(BuildContext context, bool isFavorite) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(
                child: _productImage(
                  product.imageUrl,
                  width: double.infinity,
                  height: 200,
                  horizontalCorners: false,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    final isFavorite = _isProductFavorite(state, product.id);
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        context.read<ProductCubit>().toggleFavorite(product.id);
                      },
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    final isAddedToCart = _isProductInCart(state, product.id);
                    return IconButton(
                      icon: Icon(
                        isAddedToCart
                            ? Icons.shopping_bag
                            : Icons.shopping_bag_outlined,
                        color: isAddedToCart ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        final cubit =
                            context.read<ProductCubit>(); // Get the current cubit instance
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          builder: (bottomSheetContext) {
                            return BlocProvider.value(
                              value: cubit,
                              child: ProductQuickReview(product: product),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            product.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            '${product.price.toInt()} EGP',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _productImage(
    String url, {
    bool topCornersOnly = false,
    bool horizontalCorners = false,
    double? width,
    double? height,
  }) {
    BorderRadius radius;
    if (topCornersOnly) {
      radius = const BorderRadius.vertical(top: Radius.circular(12));
    } else if (horizontalCorners) {
      radius = const BorderRadius.horizontal(left: Radius.circular(12));
    } else {
      radius = BorderRadius.circular(12);
    }

    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(borderRadius: radius, color: Colors.grey[100]),
      child: ClipRRect(
        borderRadius: radius,
        child: Image.asset(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: const Icon(Icons.image, size: 50, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }
}
