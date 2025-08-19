import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryCubitObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    Sentry.addBreadcrumb(
      Breadcrumb(
        category: 'cubit_state',
        message:
            '${bloc.runtimeType} changed: ${change.currentState} → ${change.nextState}',
        level: SentryLevel.info,
      ),
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    Sentry.captureException(
      error,
      stackTrace: stackTrace,
      withScope: (scope) {
        scope.setTag("cubit", bloc.runtimeType.toString());
        scope.setExtra("currentState", bloc.state.toString());
      },
    );
  }

}
