import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermissionHelper {
  static final Location _location = Location();

  /// Check and request location permission
  static Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Test if location services are enabled
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    // Test if permission is granted
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  /// Check if location permission is granted
  static Future<bool> isLocationPermissionGranted() async {
    final permissionStatus = await _location.hasPermission();
    return permissionStatus == PermissionStatus.granted;
  }

  /// Check if location service is enabled
  static Future<bool> isLocationServiceEnabled() async {
    return await _location.serviceEnabled();
  }

  /// Open app settings
  static Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  /// Open location settings
  static Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  /// Get current location
  static Future<LocationData?> getCurrentLocation() async {
    try {
      final hasPermission = await requestLocationPermission();
      if (!hasPermission) {
        return null;
      }

      return await _location.getLocation();
    } catch (e) {
      return null;
    }
  }
}