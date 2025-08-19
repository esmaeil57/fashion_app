import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_location.dart';
import '../../domain/usecases/check_location_permission.dart';
import '../../domain/usecases/get_current_location.dart';
import '../../domain/usecases/get_location_stream.dart';
import '../../domain/usecases/request_location_permission.dart';
import '../../domain/usecases/get_route.dart';
import '../../domain/usecases/get_distance.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetCurrentLocation getCurrentLocation;
  final RequestLocationPermission requestLocationPermission;
  final CheckLocationPermission checkLocationPermission;
  final GetLocationStream getLocationStream;
  final GetRoute getRoute;
  final GetDistance getDistance;

  StreamSubscription<UserLocation>? _locationSubscription;
  UserLocation? _currentLocation;

  LocationCubit({
    required this.getCurrentLocation,
    required this.requestLocationPermission,
    required this.checkLocationPermission,
    required this.getLocationStream,
    required this.getRoute,
    required this.getDistance,
  }) : super(const LocationInitial());

  UserLocation? get currentLocation => _currentLocation;

  Future<void> initializeLocation() async {
    try {
      emit(const LocationLoading());

      // Check and request permission
      final hasPermission = await requestLocationPermission();
      if (!hasPermission) {
        emit(const LocationPermissionDenied());
        return;
      }

      // Get current location
      final location = await getCurrentLocation();
      if (location != null) {
        _currentLocation = location;
        emit(LocationLoaded(location: location));
        
        // Start listening to location updates
        _startLocationUpdates();
      } else {
        emit(const LocationError('Unable to get current location'));
      }
    } catch (e) {
      emit(LocationError('Failed to initialize location: $e'));
    }
  }

  Future<void> refreshLocation() async {
    try {
      final hasPermission = await checkLocationPermission();
      if (!hasPermission) {
        emit(const LocationPermissionDenied());
        return;
      }

      final location = await getCurrentLocation();
      if (location != null) {
        _currentLocation = location;
        emit(LocationLoaded(location: location));
      } else {
        emit(const LocationError('Unable to refresh location'));
      }
    } catch (e) {
      emit(LocationError('Failed to refresh location: $e'));
    }
  }

  Future<void> calculateRoute(UserLocation destination) async {
    if (_currentLocation == null) {
      emit(const LocationError('Current location not available'));
      return;
    }

    try {
      emit(const RouteLoading());

      // Get route points and distance concurrently
      final futures = await Future.wait([
        getRoute(_currentLocation!, destination),
        getDistance(_currentLocation!, destination),
      ]);

      final routePoints = futures[0] as List<UserLocation>;
      final distance = futures[1] as double;

      emit(RouteLoaded(
        routePoints: routePoints,
        distance: distance,
        start: _currentLocation!,
        end: destination,
      ));
    } catch (e) {
      emit(RouteError('Failed to calculate route: $e'));
    }
  }

  void clearRoute() {
    if (_currentLocation != null) {
      emit(LocationLoaded(location: _currentLocation!));
    } else {
      emit(const LocationInitial());
    }
  }

  void _startLocationUpdates() {
    _locationSubscription?.cancel();
    _locationSubscription = getLocationStream().listen(
      (location) {
        _currentLocation = location;
        
        // Only emit LocationUpdated if we're not showing a route
        if (state is! RouteLoaded && state is! RouteLoading) {
          emit(LocationUpdated(location: location));
        }
      },
      onError: (error) {
        emit(LocationError('Location stream error: $error'));
      },
    );
  }

  void stopLocationUpdates() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}