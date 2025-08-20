import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/user_location.dart';

class MapsUtils {
  /// Convert UserLocation to LatLng
  static LatLng userLocationToLatLng(UserLocation location) {
    return LatLng(location.latitude, location.longitude);
  }

  /// Convert LatLng to UserLocation
  static UserLocation latLngToUserLocation(LatLng latLng) {
    return UserLocation(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  /// Calculate zoom level based on distance
  static double calculateZoomLevel(double radiusInKm) {
    if (radiusInKm >= 100) return 8.0;
    if (radiusInKm >= 50) return 9.0;
    if (radiusInKm >= 20) return 10.0;
    if (radiusInKm >= 10) return 11.0;
    if (radiusInKm >= 5) return 12.0;
    if (radiusInKm >= 2) return 13.0;
    if (radiusInKm >= 1) return 14.0;
    if (radiusInKm >= 0.5) return 15.0;
    return 16.0;
  }

  /// Get map style (you can customize this)
  static String? getMapStyle() {
    return '''
    [
      {
        "featureType": "poi.business",
        "stylers": [{"visibility": "off"}]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.text",
        "stylers": [{"visibility": "off"}]
      }
    ]
    ''';
  }
}

// Additional widget for showing route information
class RouteInfoCard extends StatelessWidget {
  final double distance;
  final VoidCallback? onClose;

  const RouteInfoCard({
    super.key,
    required this.distance,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: 16,
      right: 16,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(
                Icons.route,
                color: AppColors.red,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Route Distance',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${distance.toStringAsFixed(2)} km',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              ),
              if (onClose != null)
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                  iconSize: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for map controls
class MapControls extends StatelessWidget {
  final VoidCallback onCurrentLocation;
  final VoidCallback? onClearRoute;
  final bool showClearRoute;

  const MapControls({
    super.key,
    required this.onCurrentLocation,
    this.onClearRoute,
    this.showClearRoute = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      right: 16,
      child: Column(
        children: [
          if (showClearRoute && onClearRoute != null)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onClearRoute,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.clear,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onCurrentLocation,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.my_location,
                    color: AppColors.red,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom marker widget 
class CustomMarkerWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final double size;

  const CustomMarkerWidget({
    super.key,
    this.color = AppColors.red,
    this.icon = Icons.location_on,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: size * 0.6,
      ),
    );
  }
}