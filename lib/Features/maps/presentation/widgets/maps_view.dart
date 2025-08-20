import 'package:fashion/core/utils/styles/color/app_colors.dart';
import 'package:fashion/features/maps/presentation/widgets/current_location_button.dart';
import 'package:fashion/features/maps/presentation/widgets/location_info_bottom_sheet.dart';
import 'package:fashion/features/maps/presentation/widgets/route_options_buttom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/user_location.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';

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
  UserLocation? _selectedLocation;

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
            myLocationEnabled: true, 
            myLocationButtonEnabled: false, // We'll use custom button
            compassEnabled: true,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            onTap: _onMapTapped,
            onLongPress: _onMapLongPressed,
          ),
          
          // Custom Current Location Button
          Positioned(
            bottom: 100,
            right: 16,
            child: Column(
              children: [
                // Clear Route Button (show only when route is active)
                if (_polylines.isNotEmpty || _selectedLocation != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _clearSelection,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                
                // Current Location Button
                CurrentLocationButton(
                  onPressed: _moveToCurrentLocation,
                ),
              ],
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
          
          // Route Info Card (show when route is loaded)
          BlocBuilder<LocationCubit, LocationState>(
            builder: (context, state) {
              if (state is RouteLoaded) {
                return _buildRouteInfoCard(state.distance);
              }
              return const SizedBox.shrink();
            },
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
      _updateMarkers();
    });

    // Only animate to location if no selected location
    if (_selectedLocation == null) {
      _animateToLocation(location);
    }
  }

  void _updateMarkers() {
    setState(() {
      _markers = {};
      
      // Add current location marker
      if (_currentLocation != null) {
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(_currentLocation!.latitude, _currentLocation!.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
              title: 'Your Location',
              snippet: 'Current position',
              onTap: () => _showLocationInfo(_currentLocation!),
            ),
          ),
        );
      }
      
      // Add selected location marker
      if (_selectedLocation != null) {
        _markers.add(
          Marker(
            markerId: const MarkerId('selected_location'),
            position: LatLng(_selectedLocation!.latitude, _selectedLocation!.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
              title: 'Selected Location',
              snippet: 'Tap for route options',
              onTap: () => _showRouteOptions(_selectedLocation!),
            ),
            onTap: () => _showRouteOptions(_selectedLocation!),
          ),
        );
      }
    });
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
    // Set selected location on tap
    setState(() {
      _selectedLocation = UserLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
    });
    
    // Clear any existing route
    if (_polylines.isNotEmpty) {
      context.read<LocationCubit>().clearRoute();
      setState(() {
        _polylines.clear();
      });
    }
    
    _updateMarkers();
    if (_selectedLocation != null) {
      _showRouteOptions(_selectedLocation!);
    }
  }

  void _onMapLongPressed(LatLng position) {
    // Alternative way to select location with long press
    _onMapTapped(position);
  }

  void _showLocationInfo(UserLocation location) {
    showModalBottomSheet(
      context: context,
      builder: (modalContext) => LocationInfoBottomSheet(location: location),
    );
  }

   
  void _showRouteOptions(UserLocation selectedLocation) {
    showModalBottomSheet(
      context: context,
      builder: (context) => RouteOptionsBottomSheet(
        currentLocation: _currentLocation ?? UserLocation(latitude: 0, longitude: 0, timestamp: DateTime.now().millisecondsSinceEpoch),
        selectedLocation: selectedLocation,
        onGetRoute: () {},
        onClearSelection: _clearSelection,
        onRouteFound: (directions) {
          setState(() {
            _polylines.add(
              Polyline(
                polylineId: const PolylineId('route'),
                points: directions.polylinePoints,
                color: AppColors.red,
                width: 5,
              ),
            );
          });
        },
      ),
    );
  }
  void _clearSelection() {
    setState(() {
      _selectedLocation = null;
      _polylines.clear();
    });
    
    context.read<LocationCubit>().clearRoute();
    _updateMarkers();
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

  Widget _buildRouteInfoCard(double distance) {
    return Positioned(
      top: 100,
      left: 16,
      right: 16,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(
                Icons.route,
                color: AppColors.red,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Route Distance',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${distance.toStringAsFixed(2)} km',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: _clearSelection,
                iconSize: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}