import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/core/utils/styles/fonts/app_styles.dart';
import '../../../maps/presentation/pages/maps_page.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cost_details_section.dart';
import '../widgets/empty_cart_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController _campaignController = TextEditingController();

  @override
  void dispose() {
    _campaignController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<CartCubit>()..loadCart(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartItemAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.productName} added to cart (${state.quantity})'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state is CartItemRemoved) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.productName} removed from cart'),
                  backgroundColor: Colors.orange,
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state is CartItemUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.productName} quantity updated to ${state.newQuantity}'),
                  backgroundColor: Colors.blue,
                  duration: const Duration(seconds: 1),
                ),
              );
            } else if (state is CartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.message}'),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CartError && state is! CartLoaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red),
                    SizedBox(height: 16),
                    Text('Error: ${state.message}'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<CartCubit>().loadCart(),
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is CartLoaded) {
              if (state.items.isEmpty) {
                return const EmptyCartWidget();
              }

              return Stack(
                children: [
                  Column(
                    children: [
                      // Extra discount banner
                      _buildDiscountBanner(),
                      
                      // Cart items list
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            final item = state.items[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: CartItemCard(
                                item: item,
                                onQuantityChanged: (newQuantity) {
                                  context.read<CartCubit>().updateItemQuantity(item, newQuantity);
                                },
                                onRemove: () {
                                  context.read<CartCubit>().removeItemFromCart(
                                    item.productId,
                                    item.selectedSize,
                                    item.selectedColor,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      // Campaign code section
                      _buildCampaignCodeSection(),

                      // Total section
                      _buildTotalSection(state),
                      
                      // Proceed button
                      _buildProceedButton(state),
                    ],
                  ),

                  // Maps floating action button
                  Positioned(
                    bottom: 100,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () => _openMaps(context),
                      backgroundColor: AppColors.redAccent,
                      foregroundColor: AppColors.white,
                      heroTag: "maps_btn",
                      child: const Icon(Icons.location_on),
                    ),
                  ),
                ],
              );
            }

            return Stack(
              children: [
                const EmptyCartWidget(),
                
                // Maps floating action button (always visible)
                Positioned(
                  bottom: 100,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: () => _openMaps(context),
                    backgroundColor: AppColors.redAccent,
                    foregroundColor: AppColors.white,
                    heroTag: "maps_btn",
                    child: const Icon(Icons.location_on),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _openMaps(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MapsPage(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: AppColors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final itemCount = state is CartLoaded ? state.totalItems : 0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Shopping Cart',
                style: AppStyles.styleMedium18(context).copyWith(
                  color: AppColors.black,
                ),
              ),
              Text(
                '($itemCount Products)',
                style: AppStyles.styleRegular14(context).copyWith(
                  color: AppColors.gray,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDiscountBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grayLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Get extra 5% off at cart on app! Only for credit card payments!',
        style: AppStyles.styleRegular14(context).copyWith(
          color: AppColors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCampaignCodeSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _campaignController,
              decoration: InputDecoration(
                hintText: 'Campaign Code',
                hintStyle: AppStyles.styleRegular14(context).copyWith(
                  color: AppColors.gray,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                // Apply campaign code logic
                if (_campaignController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Campaign code functionality coming soon'),
                      backgroundColor: AppColors.gray,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Use',
                style: AppStyles.styleRegular14(context).copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection(CartLoaded state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderColor, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'GRAND TOTAL',
            style: AppStyles.styleBold16(context).copyWith(
              color: AppColors.black,
            ),
          ),
          Text(
            '${state.total.toStringAsFixed(2)} EGP',
            style: AppStyles.styleBold16(context).copyWith(
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProceedButton(CartLoaded state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          // Navigate to cost details
          _showCostDetails(context, state);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.redAccent,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Text(
          'PROCEED TO PAYMENT',
          style: AppStyles.styleMedium16(context).copyWith(
            color: AppColors.white,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  void _showCostDetails(BuildContext context, CartLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CostDetailsSection(state: state),
    );
  }
}