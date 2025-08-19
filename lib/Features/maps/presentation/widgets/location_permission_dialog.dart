import 'package:flutter/material.dart';
import '../../../../core/utils/styles/color/app_colors.dart';
import '../../../../core/utils/styles/fonts/app_styles.dart';
import '../../../../core/utils/location/location_permission_helper.dart';

class LocationPermissionDialog extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onCancel;

  const LocationPermissionDialog({
    super.key,
    required this.onRetry,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          const Icon(
            Icons.location_off,
            color: AppColors.redAccent,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Location Permission',
              style: AppStyles.styleBold16(context).copyWith(
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        'This app needs location permission to show your current location on the map. Please grant permission to continue.',
        style: AppStyles.styleRegular16(context).copyWith(
          color: AppColors.gray,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            'Cancel',
            style: AppStyles.styleMedium16(context).copyWith(
              color: AppColors.gray,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            // Try to open app settings
            await LocationPermissionHelper.openAppSettings();
            onRetry();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.redAccent,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Open Settings',
            style: AppStyles.styleMedium16(context).copyWith(
              color: AppColors.white,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onRetry,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.redAccent,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Retry',
            style: AppStyles.styleMedium16(context).copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}