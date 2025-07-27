import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/features/products/presentation/cubit/product_cubit.dart';
import 'package:fashion/features/products/data/repositories/product_repository_impl.dart';
import 'package:fashion/features/products/domain/usecase/get_products.dart';
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
      create: (_) => ProductCubit(  
        getAllProducts: GetAllProducts(ProductRepositoryImpl()),
        getProducts: GetProducts(ProductRepositoryImpl()),
        searchProducts: SearchProducts(ProductRepositoryImpl()),
      )..loadProducts(widget.categoryId),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: ProductsAppBar(
          searchController: _searchController,
          onSearch: () => _showSearchDialog(context),
        ),
        body: Column(
          children:  [
            Divider(color: Colors.grey[300], thickness: 1),
            SortAndViewToggle(),
            Divider( color: Colors.grey[300], thickness: 1),
            Expanded(child: ProductListView(categoryId: widget.categoryId ,),),
          ],
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
          ),
          onSubmitted: (value) {
            context.read<ProductCubit>().searchProductsInCategory(value);
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
              context.read<ProductCubit>().searchProductsInCategory(_searchController.text);
              Navigator.pop(ctx);
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
