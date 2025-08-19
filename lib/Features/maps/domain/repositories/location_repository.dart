import '../entities/user_location.dart';

abstract class LocationRepository {
  Future<bool> requestLocationPermission();
  Future<bool> isLocationPermissionGranted();
  Future<bool> isLocationServiceEnabled();
  Future<UserLocation?> getCurrentLocation();
  Stream<UserLocation> getLocationStream();
  Future<void> openAppSettings();
  Future<void> openLocationSettings();
}