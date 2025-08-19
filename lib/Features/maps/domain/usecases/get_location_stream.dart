import '../entities/user_location.dart';
import '../repositories/location_repository.dart';

class GetLocationStream {
  final LocationRepository repository;

  GetLocationStream(this.repository);

  Stream<UserLocation> call() {
    return repository.getLocationStream();
  }
}