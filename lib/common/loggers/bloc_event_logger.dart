import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocEventLogger extends BlocObserver {
  final String blocErrorLogTag = "Bloc-Error";
  final String blocEventLogTag = "Bloc-Event";

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    String info =
        blocEventLogTag + ": " + event.toString() + " from " + bloc.toString();
    if (kDebugMode) {
      log('onEvent(${bloc.runtimeType}, $event)');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    String errorInfo =
        blocErrorLogTag + " from " + bloc.toString() + ": " + error.toString();
    if (kDebugMode) {
      log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    }
  }
}
