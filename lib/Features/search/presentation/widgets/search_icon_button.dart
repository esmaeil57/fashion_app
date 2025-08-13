import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/dependency_injection/injector.dart';
import '../cubit/search_cubit.dart';
import 'search_page.dart';

class SearchIconButton extends StatelessWidget {
  final Color? iconColor;
  final double? iconSize;

  const SearchIconButton({
    super.key,
    this.iconColor,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.search,
        color: iconColor ?? Colors.black,
        size: iconSize,
      ),
      onPressed: () => _navigateToSearch(context),
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