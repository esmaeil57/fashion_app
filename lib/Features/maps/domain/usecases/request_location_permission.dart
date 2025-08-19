import '../repositories/location_repository.dart';

class RequestLocationPermission {
  final LocationRepository repository;

  RequestLocationPermission(this.repository);

  Future<bool> call() async {
    return await repository.requestLocationPermission();
  }
}
