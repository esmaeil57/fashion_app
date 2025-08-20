import 'dart:math';
import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/entities/user_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/services/directions_service.dart';
import '../../domain/entities/directions.dart';


class RouteOptionsBottomSheet extends StatelessWidget {
  final UserLocation currentLocation;
  final UserLocation selectedLocation;
  final VoidCallback onGetRoute;
  final VoidCallback onClearSelection;
  final Function(Directions) onRouteFound;

  const RouteOptionsBottomSheet({
    super.key,
    required this.currentLocation,
    required this.selectedLocation,
    required this.onGetRoute,
    required this.onClearSelection, 
    required this.onRouteFound,
  });
  @override
  Widget build(BuildContext context) {
    // Calculate straight-line distance for preview
    final straightLineDistance = _calculateStraightLineDistance(
      currentLocation,
      selectedLocation,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            
            // Title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: AppColors.red,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Location',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Choose an action',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.gray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Location Details Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.gray.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.place, color: AppColors.red, size: 16),
                      const SizedBox(width: 8),
                      const Text(
                        'Coordinates:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => _copyToClipboard(
                          context,
                          '${selectedLocation.latitude}, ${selectedLocation.longitude}',
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.copy, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              'Copy',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${selectedLocation.latitude.toStringAsFixed(6)}, ${selectedLocation.longitude.toStringAsFixed(6)}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.straighten, color: AppColors.red, size: 16),
                      const SizedBox(width: 8),
                      const Text(
                        'Straight line distance:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${straightLineDistance.toStringAsFixed(2)} km',
                    style: const TextStyle(
                      color: AppColors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Action Buttons
            Column(
              children: [
                // Get Route Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: ()=>_getRoute(context),
                    icon: const Icon(Icons.directions),
                    label: const Text('Get Route'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Share Location Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _shareLocation(context),
                    icon: const Icon(Icons.share),
                    label: const Text('Share Location'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: AppColors.red),
                      foregroundColor: AppColors.red,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Clear Selection Button
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      onClearSelection();
                    },
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear Selection'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Tip
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.fontColor,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Tap anywhere on the map to select a different location',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Add safe area padding
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }


Future<void> _getRoute(BuildContext context) async {
    try {
      final directionsService = DirectionsService();
      
      final directions = await directionsService.getDirections(
        origin: LatLng(currentLocation.latitude, currentLocation.longitude),
        destination: LatLng(selectedLocation.latitude, selectedLocation.longitude),
      );

      final routeDirections = Directions.fromMap(directions);
      onRouteFound(routeDirections);
      
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get route directions'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  double _calculateStraightLineDistance(UserLocation start, UserLocation end) {
    // Using Haversine formula for more accurate distance calculation
    const double earthRadius = 6371; // Earth's radius in kilometers
    
    final double lat1Rad = start.latitude * (3.14159265359 / 180);
    final double lat2Rad = end.latitude * (3.14159265359 / 180);
    final double deltaLatRad = (end.latitude - start.latitude) * (3.14159265359 / 180);
    final double deltaLngRad = (end.longitude - start.longitude) * (3.14159265359 / 180);
    final double a = pow(sin(deltaLatRad / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) *
        pow(sin(deltaLngRad / 2), 2);
    
    final double c = 2 * asin(sqrt(a));    
    return earthRadius * c;
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.white, size: 20),
            SizedBox(width: 8),
            Text('Coordinates copied to clipboard'),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _shareLocation(BuildContext context) {
    final String locationText = 'Location: ${selectedLocation.latitude.toStringAsFixed(6)}, ${selectedLocation.longitude.toStringAsFixed(6)}';
    final String googleMapsUrl = 'https://maps.google.com/maps?q=${selectedLocation.latitude},${selectedLocation.longitude}';
    final String shareText = '$locationText\n\nView on Google Maps: $googleMapsUrl';
    
    // You can implement actual sharing here using share_plus package
    // For now, we'll copy to clipboard
    Clipboard.setData(ClipboardData(text: shareText));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.share, color: AppColors.white, size: 20),
            SizedBox(width: 8),
            Text('Location info copied to clipboard'),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
    
    Navigator.pop(context);
  }
}