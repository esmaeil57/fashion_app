import '../../domain/entities/user_location.dart';

abstract class LocationState {
  const LocationState();
}

class LocationInitial extends LocationState {
  const LocationInitial();
}

class LocationLoading extends LocationState {
  const LocationLoading();
}

class LocationLoaded extends LocationState {
  final UserLocation location;

  const LocationLoaded({required this.location});
}

class LocationError extends LocationState {
  final String message;

  const LocationError(this.message);
}

class LocationPermissionDenied extends LocationState {
  const LocationPermissionDenied();
}

class LocationServiceDisabled extends LocationState {
  const LocationServiceDisabled();
}

class LocationUpdated extends LocationState {
  final UserLocation location;

  const LocationUpdated({required this.location});
}

class RouteLoaded extends LocationState {
  final List<UserLocation> routePoints;
  final double distance;
  final UserLocation start;
  final UserLocation end;

  const RouteLoaded({
    required this.routePoints,
    required this.distance,
    required this.start,
    required this.end,
  });
}

class RouteLoading extends LocationState {
  const RouteLoading();
}

class RouteError extends LocationState {
  final String message;

  const RouteError(this.message);
}

// Additional state for when location is being refreshed
class LocationRefreshing extends LocationState {
  final UserLocation currentLocation;
  
  const LocationRefreshing({required this.currentLocation});
}