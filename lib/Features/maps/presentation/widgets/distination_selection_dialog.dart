import 'package:flutter/material.dart';
import '../../../../core/utils/styles/color/app_colors.dart';
import '../../../../core/utils/styles/fonts/app_styles.dart';
import '../../domain/entities/user_location.dart';

class DestinationSelectionDialog extends StatefulWidget {
  final Function(UserLocation) onDestinationSelected;

  const DestinationSelectionDialog({
    super.key,
    required this.onDestinationSelected,
  });

  @override
  State<DestinationSelectionDialog> createState() => _DestinationSelectionDialogState();
}

class _DestinationSelectionDialogState extends State<DestinationSelectionDialog> {
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Predefined popular destinations in Cairo
  final List<Map<String, dynamic>> _popularDestinations = [
    {
      'name': 'Cairo Tower',
      'location': UserLocation(latitude: 30.0458, longitude: 31.2239),
    },
    {
      'name': 'Tahrir Square',
      'location': UserLocation(latitude: 30.0444, longitude: 31.2357),
    },
    {
      'name': 'Cairo International Airport',
      'location': UserLocation(latitude: 30.1219, longitude: 31.4056),
    },
    {
      'name': 'Khan el-Khalili',
      'location': UserLocation(latitude: 30.0472, longitude: 31.2620),
    },
    {
      'name': 'Giza Pyramids',
      'location': UserLocation(latitude: 29.9773, longitude: 31.1325),
    },
  ];

  @override
  void dispose() {
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          const Icon(
            Icons.place,
            color: AppColors.redAccent,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Select Destination',
              style: AppStyles.styleBold16(context).copyWith(
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Popular Destinations',
              style: AppStyles.styleMedium16(context).copyWith(
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: _popularDestinations.length,
                itemBuilder: (context, index) {
                  final destination = _popularDestinations[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.location_on,
                      color: AppColors.redAccent,
                      size: 20,
                    ),
                    title: Text(
                      destination['name'],
                      style: AppStyles.styleRegular14(context).copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    onTap: () {
                      widget.onDestinationSelected(destination['location']);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              'Or Enter Coordinates',
              style: AppStyles.styleMedium16(context).copyWith(
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _latController,
                    decoration: InputDecoration(
                      labelText: 'Latitude',
                      labelStyle: AppStyles.styleRegular14(context).copyWith(
                        color: AppColors.gray,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter latitude';
                      }
                      final lat = double.tryParse(value);
                      if (lat == null || lat < -90 || lat > 90) {
                        return 'Invalid latitude (-90 to 90)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lngController,
                    decoration: InputDecoration(
                      labelText: 'Longitude',
                      labelStyle: AppStyles.styleRegular14(context).copyWith(
                        color: AppColors.gray,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter longitude';
                      }
                      final lng = double.tryParse(value);
                      if (lng == null || lng < -180 || lng > 180) {
                        return 'Invalid longitude (-180 to 180)';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: AppStyles.styleMedium16(context).copyWith(
              color: AppColors.gray,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final lat = double.parse(_latController.text);
              final lng = double.parse(_lngController.text);
              final location = UserLocation(latitude: lat, longitude: lng);
              widget.onDestinationSelected(location);
              Navigator.of(context).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.redAccent,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Set Destination',
            style: AppStyles.styleMedium16(context).copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}