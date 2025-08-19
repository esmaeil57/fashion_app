import 'package:location/location.dart';
import '../../../../core/utils/location/location_permission_helper.dart';
import '../models/user_location_model.dart';

abstract class LocationDataSource {
  Future<bool> requestLocationPermission();
  Future<bool> isLocationPermissionGranted();
  Future<bool> isLocationServiceEnabled();
  Future<UserLocationModel?> getCurrentLocation();
  Stream<UserLocationModel> getLocationStream();
  Future<void> openAppSettings();
  Future<void> openLocationSettings();
}

class LocationDataSourceImpl implements LocationDataSource {
  final Location _location = Location();

  @override
  Future<bool> requestLocationPermission() async {
    return await LocationPermissionHelper.requestLocationPermission();
  }

  @override
  Future<bool> isLocationPermissionGranted() async {
    return await LocationPermissionHelper.isLocationPermissionGranted();
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    return await LocationPermissionHelper.isLocationServiceEnabled();
  }

  @override
  Future<UserLocationModel?> getCurrentLocation() async {
    try {
      final locationData = await LocationPermissionHelper.getCurrentLocation();
      if (locationData != null) {
        return UserLocationModel.fromLocationData(locationData);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get current location: $e');
    }
  }

  @override
  Stream<UserLocationModel> getLocationStream() {
    return _location.onLocationChanged.map((locationData) {
      return UserLocationModel.fromLocationData(locationData);
    });
  }

  @override
  Future<void> openAppSettings() async {
    await LocationPermissionHelper.openAppSettings();
  }

  @override
  Future<void> openLocationSettings() async {
    await LocationPermissionHelper.openLocationSettings();
  }
}