import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/dependency_injection/injector.dart';
import '../../../../core/utils/styles/color/app_colors.dart';
import '../../../../core/utils/styles/fonts/app_styles.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';
import '../widgets/location_permission_dialog.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

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
            'My Location',
            style: AppStyles.styleMedium18(context).copyWith(
              color: AppColors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationPermissionDenied) {
              _showPermissionDialog(context);
            } else if (state is LocationLoaded || state is LocationUpdated) {
              final location = state is LocationLoaded ? state.location : (state as LocationUpdated).location;
              _updateMapLocation(location.latitude, location.longitude);
              _updateMarker(location.latitude, location.longitude);
            } else if (state is LocationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
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
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: true,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                ),

                // Loading indicator
                if (state is LocationLoading)
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
                  bottom: 100,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: () {
                      context.read<LocationCubit>().refreshLocation();
                    },
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.redAccent,
                    child: const Icon(Icons.my_location),
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

  void _updateMarker(double latitude, double longitude) {
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(latitude, longitude),
          infoWindow: const InfoWindow(
            title: 'My Location',
            snippet: 'Current position',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      };
    });
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
  
}