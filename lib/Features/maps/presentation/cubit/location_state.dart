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
