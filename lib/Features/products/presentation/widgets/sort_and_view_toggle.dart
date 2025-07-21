import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

enum SortOption { recommended, lowestPrice, highestPrice }

class SortAndViewToggle extends StatelessWidget {
  const SortAndViewToggle({super.key});

  void _showSortOptions(BuildContext context) {
    SortOption selectedOption = SortOption.recommended;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //handle bar
                    Container(
                      width: 80,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.import_export,
                              color: Colors.black,
                              size: 24,
                            ),
                            const Text(
                              "SORT",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            print('Selected Sort: $selectedOption');
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Apply",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Sorting Options
                    RadioListTile<SortOption>(
                      title: const Text("Recommended Sorting"),
                      value: SortOption.recommended,
                      groupValue: selectedOption,
                      onChanged:
                          (value) => setState(() => selectedOption = value!),
                    ),
                    const Divider(thickness: 2, color: Colors.grey),
                    RadioListTile<SortOption>(
                      title: const Text("Lowest Price"),
                      value: SortOption.lowestPrice,
                      groupValue: selectedOption,
                      onChanged:
                          (value) => setState(() => selectedOption = value!),
                    ),
                    const Divider(thickness: 2, color: Colors.grey),
                    RadioListTile<SortOption>(
                      title: const Text("Highest Price"),
                      value: SortOption.highestPrice,
                      groupValue: selectedOption,
                      onChanged:
                          (value) => setState(() => selectedOption = value!),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          InkWell(
            onTap: () => _showSortOptions(context),
            child: const Row(
              children: [
                Icon(Icons.sort, size: 20),
                SizedBox(width: 4),
                Text('Sort'),
              ],
            ),
          ),
          const Spacer(),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (_, state) {
              final isGridView =
                  state is ProductLoaded ? state.isGridView : true;
              return Row(
                children: [
                  _ViewToggleButton(
                    icon: Icons.list_sharp,
                    isActive: !isGridView,
                    onTap: () {
                      if (isGridView) {
                        context.read<ProductCubit>().toggleViewMode();
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  _ViewToggleButton(
                    icon: Icons.grid_view,
                    isActive: isGridView,
                    onTap: () {
                      if (!isGridView) {
                        context.read<ProductCubit>().toggleViewMode();
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ViewToggleButton extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _ViewToggleButton({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon, size: 24, color: isActive ? Colors.red : Colors.black),
    );
  }
}
