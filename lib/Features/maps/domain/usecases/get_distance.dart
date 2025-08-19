import '../entities/user_location.dart';
import '../repositories/location_repository.dart';

class GetDistance {
  final LocationRepository repository;

  GetDistance(this.repository);

  Future<double> call(UserLocation start, UserLocation end) async {
    return await repository.getDistanceBetween(start, end);
  }
}