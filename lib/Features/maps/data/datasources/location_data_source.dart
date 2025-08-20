import 'dart:convert';
import 'package:fashion/core/utils/config/config_helper.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
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
  Future<List<UserLocationModel>> getRoutePoints(
    UserLocationModel start,
    UserLocationModel end,
  );
  Future<double> getDistanceBetween(
    UserLocationModel start,
    UserLocationModel end,
  );
}

class LocationDataSourceImpl implements LocationDataSource {
  final Location _location = Location();
  final Future<String> _googleMapsApiKey = ConfigHelper.getMapsApiKey();
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

  @override
  Future<List<UserLocationModel>> getRoutePoints(
    UserLocationModel start,
    UserLocationModel end,
  ) async {
    try {
      final key = await _googleMapsApiKey;
      final url =
          'https://maps.googleapis.com/maps/api/directions/json'
          '?origin=${start.latitude},${start.longitude}'
          '&destination=${end.latitude},${end.longitude}'
          '&key=$key';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['routes'].isNotEmpty) {
          final points = data['routes'][0]['overview_polyline']['points'];
          return _decodePolyline(points);
        }
      }

      // Fallback: return direct line between points
      return [start, end];
    } catch (e) {
      throw Exception('Failed to get route: $e');
    }
  }

  @override
  Future<double> getDistanceBetween(
    UserLocationModel start,
    UserLocationModel end,
  ) async {
    try {
      final distanceInMeters = Geolocator.distanceBetween(
        start.latitude,
        start.longitude,
        end.latitude,
        end.longitude,
      );

      return distanceInMeters / 1000; // Convert to kilometers
    } catch (e) {
      throw Exception('Failed to calculate distance: $e');
    }
  }

  List<UserLocationModel> _decodePolyline(String encoded) {
    List<UserLocationModel> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(UserLocationModel(latitude: lat / 1E5, longitude: lng / 1E5));
    }

    return points;
  }
}
