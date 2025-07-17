import 'package:fashion/core/common_widgets/search_bar.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          CustomSearchBar(),
          SizedBox(height: 20,),
        ],
      )
    );
  }
}