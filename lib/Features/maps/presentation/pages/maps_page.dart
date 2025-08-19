import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/dependency_injection/injector.dart';
import '../../../../core/utils/styles/color/app_colors.dart';
import '../../../../core/utils/styles/fonts/app_styles.dart';
import '../../domain/entities/user_location.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';
import '../widgets/location_permission_dialog.dart';

class MapsPage extends StatefulWidget {
  final UserLocation? destination;
  
  const MapsPage({super.key, this.destination});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(30.0444, 31.2357), // Cairo, Egypt
    zoom: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<LocationCubit>()..initializeLocation(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.destination != null ? 'Route to Destination' : 'My Location',
            style: AppStyles.styleMedium18(context).copyWith(
              color: AppColors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (state is RouteLoaded) {
                  return IconButton(
                    icon: const Icon(Icons.clear, color: AppColors.redAccent),
                    onPressed: () {
                      context.read<LocationCubit>().clearRoute();
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocConsumer<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationPermissionDenied) {
              _showPermissionDialog(context);
            } else if (state is LocationLoaded) {
              _updateMapLocation(state.location.latitude, state.location.longitude);
              _updateMarker(state.location.latitude, state.location.longitude, 'Current Location');
              
              // If destination is provided, calculate route
              if (widget.destination != null) {
                context.read<LocationCubit>().calculateRoute(widget.destination!);
              }
            } else if (state is LocationUpdated) {
              _updateMapLocation(state.location.latitude, state.location.longitude);
              _updateMarker(state.location.latitude, state.location.longitude, 'Current Location');
            } else if (state is RouteLoaded) {
              _showRoute(state);
            } else if (state is LocationError || state is RouteError) {
              final message = state is LocationError ? state.message : (state as RouteError).message;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                // Google Map
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  initialCameraPosition: _initialCamera,
                  markers: _markers,
                  polylines: _polylines,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: true,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  onTap: (LatLng position) {
                    if (widget.destination == null) {
                      // Allow user to set destination by tapping
                      final destination = UserLocation(
                        latitude: position.latitude,
                        longitude: position.longitude,
                      );
                      context.read<LocationCubit>().calculateRoute(destination);
                    }
                  },
                ),

                // Loading indicator
                if (state is LocationLoading || state is RouteLoading)
                  Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.redAccent),
                      ),
                    ),
                  ),

                // Back to location button
                Positioned(
                  bottom: 180,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: () {
                      context.read<LocationCubit>().refreshLocation();
                    },
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.redAccent,
                    heroTag: "location_btn",
                    child: const Icon(Icons.my_location),
                  ),
                ),

                // Clear route button (shown when route is active)
                if (state is RouteLoaded)
                  Positioned(
                    bottom: 120,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () {
                        context.read<LocationCubit>().clearRoute();
                      },
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.redAccent,
                      heroTag: "clear_route_btn",
                      mini: true,
                      child: const Icon(Icons.clear),
                    ),
                  ),

                // Location info card
                if (state is LocationLoaded || state is LocationUpdated)
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: _buildLocationInfoCard(context, state),
                  ),

                // Route info card
                if (state is RouteLoaded)
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: _buildRouteInfoCard(context, state),
                  ),

                // Instructions for tap to set destination
                if (widget.destination == null && (state is LocationLoaded || state is LocationUpdated))
                  Positioned(
                    top: 140,
                    left: 20,
                    right: 20,
                    child: _buildInstructionCard(context),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLocationInfoCard(BuildContext context, LocationState state) {
    final location = state is LocationLoaded ? state.location : (state as LocationUpdated).location;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.redAccent),
                const SizedBox(width: 8),
                Text(
                  'Current Location',
                  style: AppStyles.styleMedium16(context).copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Lat: ${location.latitude.toStringAsFixed(6)}',
              style: AppStyles.styleRegular14(context).copyWith(
                color: AppColors.gray,
              ),
            ),
            Text(
              'Lng: ${location.longitude.toStringAsFixed(6)}',
              style: AppStyles.styleRegular14(context).copyWith(
                color: AppColors.gray,
              ),
            ),
            if (location.accuracy != null) ...[
              const SizedBox(height: 4),
              Text(
                'Accuracy: ${location.accuracy!.toStringAsFixed(1)}m',
                style: AppStyles.styleRegular12(context).copyWith(
                  color: AppColors.gray,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRouteInfoCard(BuildContext context, RouteLoaded state) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.directions, color: AppColors.redAccent),
                const SizedBox(width: 8),
                Text(
                  'Route Information',
                  style: AppStyles.styleMedium16(context).copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Distance:',
                  style: AppStyles.styleRegular14(context).copyWith(
                    color: AppColors.gray,
                  ),
                ),
                Text(
                  '${state.distance.toStringAsFixed(2)} km',
                  style: AppStyles.styleMedium16(context).copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Route Points:',
                  style: AppStyles.styleRegular14(context).copyWith(
                    color: AppColors.gray,
                  ),
                ),
                Text(
                  '${state.routePoints.length}',
                  style: AppStyles.styleMedium16(context).copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppColors.grayLight.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.touch_app, color: AppColors.redAccent, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Tap anywhere on the map to set destination and view route',
                style: AppStyles.styleRegular12(context).copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LocationPermissionDialog(
        onRetry: () {
          Navigator.of(context).pop();
          context.read<LocationCubit>().initializeLocation();
        },
        onCancel: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop(); // Go back to previous screen
        },
      ),
    );
  }

  void _updateMapLocation(double latitude, double longitude) {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(latitude, longitude),
        ),
      );
    }
  }

  void _updateMarker(double latitude, double longitude, String title) {
    setState(() {
      _markers.removeWhere((marker) => marker.markerId.value == 'current_location');
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: title,
            snippet: 'Current position',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    });
  }

  void _showRoute(RouteLoaded state) {
    setState(() {
      _polylines.clear();
      _markers.clear();

      // Add route polyline
      final polylineCoordinates = state.routePoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: polylineCoordinates,
          color: AppColors.redAccent,
          width: 4,
          patterns: [],
        ),
      );

      // Add start marker
      _markers.add(
        Marker(
          markerId: const MarkerId('start'),
          position: LatLng(state.start.latitude, state.start.longitude),
          infoWindow: const InfoWindow(
            title: 'Start',
            snippet: 'Your location',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );

      // Add end marker
      _markers.add(
        Marker(
          markerId: const MarkerId('end'),
          position: LatLng(state.end.latitude, state.end.longitude),
          infoWindow: const InfoWindow(
            title: 'Destination',
            snippet: 'End point',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });

    // Adjust camera to show entire route
    _fitRouteInView(state.routePoints);
  }

  void _fitRouteInView(List<UserLocation> routePoints) {
    if (_mapController != null && routePoints.isNotEmpty) {
      double minLat = routePoints.first.latitude;
      double maxLat = routePoints.first.latitude;
      double minLng = routePoints.first.longitude;
      double maxLng = routePoints.first.longitude;

      for (final point in routePoints) {
        minLat = minLat > point.latitude ? point.latitude : minLat;
        maxLat = maxLat < point.latitude ? point.latitude : maxLat;
        minLng = minLng > point.longitude ? point.longitude : minLng;
        maxLng = maxLng < point.longitude ? point.longitude : maxLng;
      }

      _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(minLat, minLng),
            northeast: LatLng(maxLat, maxLng),
          ),
          100.0,
        ),
      );
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}