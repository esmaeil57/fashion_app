import 'package:location/location.dart';
import '../../domain/entities/user_location.dart';

class UserLocationModel extends UserLocation {
  const UserLocationModel({
    required super.latitude,
    required super.longitude,
    super.accuracy,
    super.altitude,
    super.speed,
    super.speedAccuracy,
    super.heading,
    super.timestamp,
  });

  factory UserLocationModel.fromLocationData(LocationData locationData) {
    return UserLocationModel(
      latitude: locationData.latitude ?? 0.0,
      longitude: locationData.longitude ?? 0.0,
      accuracy: locationData.accuracy,
      altitude: locationData.altitude,
      speed: locationData.speed,
      speedAccuracy: locationData.speedAccuracy,
      heading: locationData.heading,
      timestamp: locationData.time?.toInt(),
    );
  }

  factory UserLocationModel.fromEntity(UserLocation location) {
    return UserLocationModel(
      latitude: location.latitude,
      longitude: location.longitude,
      accuracy: location.accuracy,
      altitude: location.altitude,
      speed: location.speed,
      speedAccuracy: location.speedAccuracy,
      heading: location.heading,
      timestamp: location.timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
      'altitude': altitude,
      'speed': speed,
      'speedAccuracy': speedAccuracy,
      'heading': heading,
      'timestamp': timestamp,
    };
  }

  factory UserLocationModel.fromJson(Map<String, dynamic> json) {
    return UserLocationModel(
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      accuracy: json['accuracy']?.toDouble(),
      altitude: json['altitude']?.toDouble(),
      speed: json['speed']?.toDouble(),
      speedAccuracy: json['speedAccuracy']?.toDouble(),
      heading: json['heading']?.toDouble(),
      timestamp: json['timestamp']?.toInt(),
    );
  }
}
