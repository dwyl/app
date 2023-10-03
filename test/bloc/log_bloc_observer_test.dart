import 'package:dwyl_app/blocs/blocs.dart';
import 'package:dwyl_app/logging/logging.dart';
import 'package:dwyl_app/models/item.dart';
import 'package:flutter_test/flutter_test.dart';

// This is similar to Bloc's testing.
// See https://github.com/felangel/bloc/blob/master/packages/bloc/test/bloc_observer_test.dart.
void main() {
  final bloc = ItemBloc();
  final error = Exception();
  const stackTrace = StackTrace.empty;
  const event = AddItemEvent;
  final change = Change(currentState: const [], nextState: [Item(description: 'description')]);
  final transition = Transition(
    currentState: const [],
    event: AddItemEvent,
    nextState: [Item(description: 'description')],
  );
  group('BlocObserver', () {
    group('onCreate', () {
      test('does nothing by default (just prints logs)', () {
        // ignore: invalid_use_of_protected_member
        GlobalLogBlocObserver().onCreate(bloc);
      });
    });

    group('onEvent', () {
      test('does nothing by default (just prints logs)', () {
        // ignore: invalid_use_of_protected_member
        GlobalLogBlocObserver().onEvent(bloc, event);
      });
    });

    group('onChange', () {
      test('does nothing by default (just prints logs)', () {
        // ignore: invalid_use_of_protected_member
        GlobalLogBlocObserver().onChange(bloc, change);
      });
    });

    group('onTransition', () {
      test('does nothing by default (just prints logs)', () {
        // ignore: invalid_use_of_protected_member
        GlobalLogBlocObserver().onTransition(bloc, transition);
      });
    });

    group('onError', () {
      test('does nothing by default (just prints logs)', () {
        // ignore: invalid_use_of_protected_member
        GlobalLogBlocObserver().onError(bloc, error, stackTrace);
      });
    });

    group('onClose', () {
      test('does nothing by default (just prints logs)', () {
        // ignore: invalid_use_of_protected_member
        GlobalLogBlocObserver().onClose(bloc);
      });
    });
  });
}
