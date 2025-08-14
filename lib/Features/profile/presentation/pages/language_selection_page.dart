import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/utils/locale/locale_helper.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String selectedLanguage = 'English';
  String previewLanguage = 'English';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedLanguage =
        context.locale.languageCode == 'ar' ? 'Arabic' : 'English';
    previewLanguage = selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder:
              (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
          child: Text(
            'language_selection'.tr(),
            key: ValueKey<String>(previewLanguage),
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Egypt header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: Colors.grey[200],
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder:
                  (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
              child: Text(
                'egypt'.tr(),
                key: ValueKey<String>(previewLanguage),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Language options
          _buildLanguageOption(
            title: 'English',
            isSelected: selectedLanguage == 'English',
            onTap: () => _selectLanguage('English'),
          ),
          _buildLanguageOption(
            title: 'العربية',
            isSelected: selectedLanguage == 'Arabic',
            onTap: () => _selectLanguage('Arabic'),
          ),

          const Spacer(),

          // Continue button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _onContinuePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                  child: Text(
                    'continue'.tr().toUpperCase(),
                    key: ValueKey<String>(previewLanguage),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? AppColors.red : AppColors.gray,
              width: 2,
            ),
            color: isSelected ? AppColors.red : Colors.transparent,
          ),
          child:
              isSelected
                  ? const Icon(Icons.check, color: AppColors.white, size: 16)
                  : null,
        ),
        onTap: onTap,
      ),
    );
  }

  void _selectLanguage(String language) async {
    setState(() {
      selectedLanguage = language;
      previewLanguage = language;
    });
  }

  Future<void> _onContinuePressed() async {
    Locale newLocale =
        selectedLanguage == 'Arabic' ? const Locale('ar') : const Locale('en');

    await LocaleHelper.saveLocale(newLocale);
    if (mounted) {
      await context.setLocale(newLocale);
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
