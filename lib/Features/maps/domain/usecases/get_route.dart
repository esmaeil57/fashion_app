import '../entities/user_location.dart';
import '../repositories/location_repository.dart';

class GetRoute {
  final LocationRepository repository;

  GetRoute(this.repository);

  Future<List<UserLocation>> call(UserLocation start, UserLocation end) async {
    return await repository.getRoutePoints(start, end);
  }
}