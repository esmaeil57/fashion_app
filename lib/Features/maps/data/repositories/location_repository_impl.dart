import '../../domain/entities/user_location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_data_source.dart';
import '../models/user_location_model.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl({required this.dataSource});

  @override
  Future<bool> requestLocationPermission() async {
    try {
      return await dataSource.requestLocationPermission();
    } catch (e) {
      throw Exception('Failed to request location permission: $e');
    }
  }

  @override
  Future<bool> isLocationPermissionGranted() async {
    try {
      return await dataSource.isLocationPermissionGranted();
    } catch (e) {
      throw Exception('Failed to check location permission: $e');
    }
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    try {
      return await dataSource.isLocationServiceEnabled();
    } catch (e) {
      throw Exception('Failed to check location service: $e');
    }
  }

  @override
  Future<UserLocation?> getCurrentLocation() async {
    try {
      final locationModel = await dataSource.getCurrentLocation();
      return locationModel;
    } catch (e) {
      throw Exception('Failed to get current location: $e');
    }
  }

  @override
  Stream<UserLocation> getLocationStream() {
    try {
      return dataSource.getLocationStream();
    } catch (e) {
      throw Exception('Failed to get location stream: $e');
    }
  }

  @override
  Future<void> openAppSettings() async {
    try {
      await dataSource.openAppSettings();
    } catch (e) {
      throw Exception('Failed to open app settings: $e');
    }
  }

  @override
  Future<void> openLocationSettings() async {
    try {
      await dataSource.openLocationSettings();
    } catch (e) {
      throw Exception('Failed to open location settings: $e');
    }
  }

  @override
  Future<List<UserLocation>> getRoutePoints(UserLocation start, UserLocation end) async {
    try {
      final startModel = UserLocationModel.fromEntity(start);
      final endModel = UserLocationModel.fromEntity(end);
      final routeModels = await dataSource.getRoutePoints(startModel, endModel);
      return routeModels.cast<UserLocation>();
    } catch (e) {
      throw Exception('Failed to get route points: $e');
    }
  }

  @override
  Future<double> getDistanceBetween(UserLocation start, UserLocation end) async {
    try {
      final startModel = UserLocationModel.fromEntity(start);
      final endModel = UserLocationModel.fromEntity(end);
      return await dataSource.getDistanceBetween(startModel, endModel);
    } catch (e) {
      throw Exception('Failed to calculate distance: $e');
    }
  }
}