import 'package:flutter/material.dart';
import '../../features/search/presentation/widgets/search_page.dart';
import '../../features/search/presentation/cubit/search_cubit.dart';
import '../dependency_injection/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnhancedSearchBar extends StatelessWidget {
  final String hintText;
  final EdgeInsetsGeometry? margin;
  final bool enabled;

  const EnhancedSearchBar({
    super.key,
    this.hintText = 'Search Product',
    this.margin,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 40, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: enabled ? () => _navigateToSearch(context) : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey[600],
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    hintText,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => injector<SearchCubit>(),
          child: const SearchPage(),
        ),
      ),
    );
  }
}