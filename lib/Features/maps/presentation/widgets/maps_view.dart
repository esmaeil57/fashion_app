import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/user_location.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';
import 'current_location_button.dart';
import 'location_info_bottom_sheet.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  UserLocation? _currentLocation;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state is LocationLoaded) {
          _updateCurrentLocation(state.location);
        } else if (state is LocationUpdated) {
          _updateCurrentLocation(state.location);
        } else if (state is RouteLoaded) {
          _showRoute(state);
        }
      },
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(30.0444, 31.2357), // Cairo, Egypt default
              zoom: 15,
            ),
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true, // We'll use custom marker
            myLocationButtonEnabled: false, // We'll use custom button
            compassEnabled: true,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            onTap: _onMapTapped,
          ),
          
          // Custom Current Location Button
          Positioned(
            bottom: 100,
            right: 16,
            child: CurrentLocationButton(
              onPressed: _moveToCurrentLocation,
            ),
          ),
          
          // App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: const Text('Maps'),
              backgroundColor: Colors.white.withOpacity(0.9),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    
    // Move to current location if available
    final cubit = context.read<LocationCubit>();
    if (cubit.currentLocation != null) {
      _updateCurrentLocation(cubit.currentLocation!);
    }
  }

  void _updateCurrentLocation(UserLocation location) {
    setState(() {
      _currentLocation = location;
      _markers = {
        Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(location.latitude, location.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: 'Current Location',
            snippet: 'Lat: ${location.latitude.toStringAsFixed(6)}, '
                    'Lng: ${location.longitude.toStringAsFixed(6)}',
            onTap: () => _showLocationInfo(location),
          ),
        ),
      };
    });

    _animateToLocation(location);
  }

  void _showRoute(RouteLoaded routeState) {
    setState(() {
      _polylines = {
        Polyline(
          polylineId: const PolylineId('route'),
          points: routeState.routePoints
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList(),
          color: AppColors.red,
          width: 5,
          patterns: [], // Solid line
        ),
      };
      
      _markers = {
        Marker(
          markerId: const MarkerId('start'),
          position: LatLng(routeState.start.latitude, routeState.start.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: const InfoWindow(title: 'Start'),
        ),
        Marker(
          markerId: const MarkerId('end'),
          position: LatLng(routeState.end.latitude, routeState.end.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: 'Destination',
            snippet: 'Distance: ${routeState.distance.toStringAsFixed(2)} km',
          ),
        ),
      };
    });

    // Fit the route in the map view
    _fitRouteInView(routeState.routePoints);
  }

  void _animateToLocation(UserLocation location) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 16,
        ),
      ),
    );
  }

  void _moveToCurrentLocation() {
    if (_currentLocation != null) {
      _animateToLocation(_currentLocation!);
    } else {
      // Refresh location if not available
      context.read<LocationCubit>().refreshLocation();
    }
  }

  void _onMapTapped(LatLng position) {
    // Clear route when user taps on map
    final cubit = context.read<LocationCubit>();
    if (cubit.state is RouteLoaded) {
      cubit.clearRoute();
      setState(() {
        _polylines.clear();
      });
    }
  }

  void _showLocationInfo(UserLocation location) {
    showModalBottomSheet(
      context: context,
      builder: (context) => LocationInfoBottomSheet(location: location),
    );
  }

  void _fitRouteInView(List<UserLocation> routePoints) {
    if (routePoints.isEmpty || _mapController == null) return;

    double minLat = routePoints.first.latitude;
    double maxLat = routePoints.first.latitude;
    double minLng = routePoints.first.longitude;
    double maxLng = routePoints.first.longitude;

    for (final point in routePoints) {
      minLat = point.latitude < minLat ? point.latitude : minLat;
      maxLat = point.latitude > maxLat ? point.latitude : maxLat;
      minLng = point.longitude < minLng ? point.longitude : minLng;
      maxLng = point.longitude > maxLng ? point.longitude : maxLng;
    }

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        100.0, // padding
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
