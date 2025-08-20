import 'package:fashion/features/maps/presentation/cubit/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion/core/dependency_injection/injector.dart';
import '../cubit/location_cubit.dart';
import '../widgets/maps_view.dart';
import '../widgets/permission_denied_widget.dart';
import '../widgets/location_loading_widget.dart';
import '../widgets/location_error_widget.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<LocationCubit>()..initializeLocation(),
      child: const MapsPageContent(),
    );
  }
}

class MapsPageContent extends StatelessWidget {
  const MapsPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            return const LocationLoadingWidget();
          } else if (state is LocationPermissionDenied) {
            return PermissionDeniedWidget(
              onRetry: () => context.read<LocationCubit>().initializeLocation(),
            );
          } else if (state is LocationError) {
            return LocationErrorWidget(
              message: state.message,
              onRetry: () => context.read<LocationCubit>().initializeLocation(),
            );
          } else if (state is LocationLoaded ||
              state is LocationUpdated ||
              state is RouteLoaded) {
            return const MapsView();
          }

          return const LocationLoadingWidget();
        },
      ),
    );
  }
}
