import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_location.dart';
import '../../domain/usecases/check_location_permission.dart';
import '../../domain/usecases/get_current_location.dart';
import '../../domain/usecases/get_location_stream.dart';
import '../../domain/usecases/request_location_permission.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetCurrentLocation getCurrentLocation;
  final RequestLocationPermission requestLocationPermission;
  final CheckLocationPermission checkLocationPermission;
  final GetLocationStream getLocationStream;

  StreamSubscription<UserLocation>? _locationSubscription;
  UserLocation? _currentLocation;

  LocationCubit({
    required this.getCurrentLocation,
    required this.requestLocationPermission,
    required this.checkLocationPermission,
    required this.getLocationStream,
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

  void _startLocationUpdates() {
    _locationSubscription?.cancel();
    _locationSubscription = getLocationStream().listen(
      (location) {
        _currentLocation = location;
        emit(LocationUpdated(location: location));
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