import '../repositories/location_repository.dart';

class CheckLocationPermission {
  final LocationRepository repository;

  CheckLocationPermission(this.repository);

  Future<bool> call() async {
    return await repository.isLocationPermissionGranted();
  }
}