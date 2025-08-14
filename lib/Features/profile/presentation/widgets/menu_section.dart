import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../pages/language_selection_page.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMenuItem('order_tracking'.tr(), () {}),
        Divider(color: Colors.grey[300]),
        _buildMenuItem('help'.tr(), () {}),
        Divider(color: Colors.grey[300]),
        const SizedBox(height: 20),
        Text(
          'fig_support'.tr(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildSupportItem(Icons.description, 'contact_form'.tr(), () {}),
        const SizedBox(height: 8),
        _buildSupportItem(Icons.phone, 'contact_form'.tr(), () {}),
        const SizedBox(height: 30),
        Text(
          'language_selection_title'.tr().toUpperCase(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _navigateToLanguageSelection(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.language, color: Colors.grey),
                const SizedBox(width: 12),
                Text(
                  _getCurrentLanguageDisplay(context),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildSupportItem(IconData icon, String title, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  String _getCurrentLanguageDisplay(BuildContext context) {
    final currentLocale = context.locale.languageCode;
    return currentLocale == 'ar' ? 'العربية' : 'English';
  }

  void _navigateToLanguageSelection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LanguageSelectionPage(),
      ),
    );
  }
}