import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

enum SortOption { recommended, lowestPrice, highestPrice }

class SortAndViewToggle extends StatefulWidget {
  const SortAndViewToggle({super.key});

  @override
  State<SortAndViewToggle> createState() => _SortAndViewToggleState();
}

class _SortAndViewToggleState extends State<SortAndViewToggle> {
  SortOption _selectedOption = SortOption.recommended;

  void _showSortOptions(BuildContext parentContext) {
    SortOption selectedOption = _selectedOption;

    showModalBottomSheet(
      context: parentContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setStateSheet) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(bottomSheetContext),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.import_export,
                              color: Colors.black,
                              size: 24,
                            ),
                            Text(
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
                            // Save choice to widget state
                            setState(() {
                              _selectedOption = selectedOption;
                            });
                            // Map choice to sort string
                            String sortBy;
                            switch (_selectedOption) {
                              case SortOption.lowestPrice:
                                sortBy = 'price_low_to_high';
                                break;
                              case SortOption.highestPrice:
                                sortBy = 'price_high_to_low';
                                break;
                              default:
                                sortBy = 'recommended';
                            }
                            // Call cubit sort
                            parentContext.read<ProductCubit>().sortProducts(
                              sortBy,
                            );
                            Navigator.pop(bottomSheetContext);
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
                    Column(
                      children: [
                        _buildSortOption(
                          'Recommended Sorting',
                          SortOption.recommended,
                          selectedOption,
                          (newValue) => setStateSheet(() {
                            selectedOption = newValue;
                          }),
                        ),
                        const Divider(thickness: 1, color: Colors.grey),
                        _buildSortOption(
                          'Lowest Price',
                          SortOption.lowestPrice,
                          selectedOption,
                          (newValue) => setStateSheet(() {
                            selectedOption = newValue;
                          }),
                        ),
                        const Divider(thickness: 1, color: Colors.grey),
                        _buildSortOption(
                          'Highest Price',
                          SortOption.highestPrice,
                          selectedOption,
                          (newValue) => setStateSheet(() {
                            selectedOption = newValue;
                          }),
                        ),
                      ],
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

  Widget _buildSortOption(
    String title,
    SortOption value,
    SortOption selectedOption,
    ValueChanged<SortOption> onChanged,
  ) {
    return RadioListTile<SortOption>(
      title: Text(title),
      value: value,
      groupValue: selectedOption,
      onChanged: (SortOption? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
      activeColor: Colors.red,
      contentPadding: EdgeInsets.zero,
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
