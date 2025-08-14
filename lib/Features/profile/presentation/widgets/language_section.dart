import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/profile_state.dart';

class LanguageSection extends StatelessWidget {
  final ProfileSignUpMode state;

  const LanguageSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'language_communication'.tr(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getDisplayLanguage(context, state.user.language),
                style: const TextStyle(fontSize: 16),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'language_email_note'.tr(),
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  String _getDisplayLanguage(BuildContext context, String language) {
    // Return the language in the format that matches current locale
    if (language == 'English') {
      return context.locale.languageCode == 'ar' ? 'الإنجليزية' : 'English';
    } else if (language == 'Arabic') {
      return context.locale.languageCode == 'ar' ? 'العربية' : 'Arabic';
    }
    return language;
  }
}