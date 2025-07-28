import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

class ProductQuickReview extends StatefulWidget {
  final Product product;

  const ProductQuickReview({super.key, required this.product});

  @override
  State<ProductQuickReview> createState() => _ProductQuickReviewState();
}

class _ProductQuickReviewState extends State<ProductQuickReview> {
  late PageController _pageController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizes = widget.product.sizes.isNotEmpty 
        ? widget.product.sizes 
        : ['S', 'M', 'L', 'XL', '2XL', '3XL'];
    final colors = widget.product.colors.isNotEmpty 
        ? widget.product.colors 
        : ['black'];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with Quick Review title and Cancel button
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quick Review',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image and Details
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image Carousel
                        _buildImageCarousel(),
                        
                        const SizedBox(width: 16),
                        
                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  height: 1.3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Price display with sale price support
                              Row(
                                children: [
                                  if (widget.product.isOnSale) ...[
                                    Text(
                                      '${widget.product.salePrice?.toInt()} EGP',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${widget.product.price.toInt()} EGP',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ] else
                                    Text(
                                      '${widget.product.price.toInt()} EGP',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                ],
                              ),

                              // Stock status
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    widget.product.inStock 
                                        ? Icons.check_circle 
                                        : Icons.cancel,
                                    size: 16,
                                    color: widget.product.inStock 
                                        ? Colors.green 
                                        : Colors.red,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.product.inStock 
                                        ? 'In Stock' 
                                        : 'Out of Stock',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: widget.product.inStock 
                                          ? Colors.green 
                                          : Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Colors Section
                    if (colors.isNotEmpty)
                      BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Colors:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              
                              const SizedBox(height: 12),
                              
                              Wrap(
                                spacing: 12,
                                children: colors.map((color) {
                                  final isSelected = state.selectedColor == color;
                                  return GestureDetector(
                                    onTap: () => context.read<ProductCubit>().selectColor(color),
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: isSelected
                                            ? Border.all(color: Colors.blue, width: 2)
                                            : Border.all(color: Colors.grey.shade300, width: 1),
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
                      ),
                    
                    const SizedBox(height: 24),
                    
                    // Sizes Section
                    if (sizes.isNotEmpty)
                      BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sizes:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              
                              const SizedBox(height: 12),
                              
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: sizes.map((size) {
                                  final isSelected = state.selectedSize == size;
                                  return GestureDetector(
                                    onTap: () => context.read<ProductCubit>().selectSize(size),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected ? Colors.black : Colors.white,
                                        border: Border.all(
                                          color: isSelected ? Colors.black : Colors.grey.shade300,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        size,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: isSelected ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        },
                      ),
                    
                    const SizedBox(height: 32),
                    
                    // Go to Product Details Link
                    Center(
                      child: GestureDetector(
                        onTap: () {
                        },
                        child: const Text(
                          'Go to Product Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          
          // Bottom Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                final isReady = state.selectedSize != null && state.selectedColor != null;
                final buttonText = isReady 
                    ? 'ADD TO CART' 
                    : 'CHOOSE A SIZE AND COLOR';
                
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isReady 
                        ? Colors.black 
                        : const Color.fromARGB(248, 201, 83, 83), 
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: widget.product.inStock ? () {
                    if (isReady) {
                      // Add to cart functionality
                      context.read<ProductCubit>().toggleCart(widget.product.id);
                      Navigator.pop(context);
                      
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${widget.product.name} added to cart'),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  } : null,
                  child: Text(
                    widget.product.inStock ? buttonText : 'OUT OF STOCK',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    // If no images, show placeholder
    if (widget.product.imageUrls.isEmpty) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: const Icon(Icons.image, size: 50, color: Colors.grey),
      );
    }

    // If only one image, show it directly
    if (widget.product.imageUrls.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          widget.product.imageUrls.first,
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: 120,
              height: 120,
              color: Colors.grey[200],
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 120,
              height: 120,
              color: Colors.grey[200],
              child: const Icon(Icons.image, size: 50, color: Colors.grey),
            );
          },
        ),
      );
    }

    // Multiple images - show carousel
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
              itemCount: widget.product.imageUrls.length,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.product.imageUrls[index],
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 50, color: Colors.grey),
                    );
                  },
                );
              },
            ),
          ),
          // Image indicators
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.product.imageUrls.length > 5 ? 5 : widget.product.imageUrls.length,
                (index) => Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == _currentImageIndex 
                        ? Colors.white 
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Enhanced color parser with more color options
  Color _parseColor(String color) {
    switch (color.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'white':
        return Colors.white;
      case 'grey':
      case 'gray':
        return Colors.grey;
      case 'pink':
        return Colors.pink;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
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