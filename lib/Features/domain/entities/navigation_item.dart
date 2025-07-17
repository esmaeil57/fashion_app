import 'package:flutter/material.dart';

class NavigationItem {
  final String title;
  final IconData icon;
  final IconData? activeIcon;

  NavigationItem({
    required this.title,
    required this.icon,
    this.activeIcon,
  });
}