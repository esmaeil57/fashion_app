import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/core/dependency_injection/injector.dart';
import 'package:fashion/features/products/presentation/cubit/product_cubit.dart';
import '../widgets/products_app_bar.dart';
import '../widgets/sort_and_view_toggle.dart';
import '../widgets/product_list_view.dart';

class ProductsPage extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const ProductsPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (_) => injector<ProductCubit>()..loadProducts(widget.categoryId),
    child: Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: ProductsAppBar(
        searchController: _searchController,
        onSearch: () => _showSearchDialog(context),
        categoryName: widget.categoryName,
      ),
      body: SafeArea(
        child: ConstrainedBox(  
          constraints: const BoxConstraints.expand(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Divider(color: Colors.grey[300], thickness: 1),
              const SortAndViewToggle(),
              Divider(color: Colors.grey[300], thickness: 1),
              Expanded(
                child: ProductListView(
                  categoryId: widget.categoryId,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Search Products'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Enter product name...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              context.read<ProductCubit>().searchProductsInCategory(value.trim());
            }
            Navigator.pop(ctx);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _searchController.clear();
              context.read<ProductCubit>().clearSearch();
              Navigator.pop(ctx);
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () {
              final query = _searchController.text.trim();
              if (query.isNotEmpty) {
                context.read<ProductCubit>().searchProductsInCategory(query);
              }
              Navigator.pop(ctx);
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}