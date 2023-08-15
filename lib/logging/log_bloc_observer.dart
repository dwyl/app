import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';

class GlobalLogBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logMessage('${bloc.runtimeType} event dispatch: $event.');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logMessage('${bloc.runtimeType} transition: Event ${transition.event} was dispatched. Transition occurred from ${transition.currentState} to ${transition.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    logWarning('${bloc.runtimeType} error: $error.');
    logError('Stacktrace: \n$stackTrace');
  }
}
