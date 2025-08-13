import 'package:fashion/core/shared_widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import 'product_card.dart';

class ProductListView extends StatefulWidget {
  final String categoryId;
  const ProductListView({super.key, required this.categoryId,});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  void initState() {
    super.initState();
    // Trigger loading when this widget is inserted in the tree
    Future.microtask(() async{
      final cubit = context.read<ProductCubit>();
      if (widget.categoryId == 'all') {
        cubit.loadAllProducts();
      } else {
        cubit.loadProducts(widget.categoryId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (_, state) {
        if (state is ProductLoading) {
          return BlocBuilder<ProductCubit, ProductState>(
            builder: (context, prevState) {
              final isGridView =
                  prevState is ProductLoaded ? prevState.isGridView : true;
              return isGridView
                  ? const ProductGridShimmerLoading()
                  : const ProductListShimmerLoading();
            },
          );
        }

        if (state is ProductError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final cubit = context.read<ProductCubit>();
                    if (widget.categoryId == 'all') {
                      cubit.loadAllProducts();
                    } else {
                      cubit.loadProducts(widget.categoryId);
                    }
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is ProductLoaded) {
          if (state.products.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No products found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return state.isGridView
              ? GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: state.products.length,
                itemBuilder:
                    (_, index) => ProductCard(
                      product: state.products[index],
                      isGridView: true,
                    ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.products.length,
                itemBuilder:
                    (_, index) => ProductCard(
                      product: state.products[index],
                      isGridView: false,
                    ),
              );
        }

        return const SizedBox();
      },
    );
  }
}
