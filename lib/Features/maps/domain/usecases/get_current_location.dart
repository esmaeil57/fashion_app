import '../entities/user_location.dart';
import '../repositories/location_repository.dart';

class GetCurrentLocation {
  final LocationRepository repository;

  GetCurrentLocation(this.repository);

  Future<UserLocation?> call() async {
    return await repository.getCurrentLocation();
  }
}