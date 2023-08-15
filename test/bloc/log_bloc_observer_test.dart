import 'package:dwyl_todo/blocs/todo/todo_bloc.dart';
import 'package:dwyl_todo/logging/logging.dart';
import 'package:dwyl_todo/models/item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

// This is similar to Bloc's testing.
// See https://github.com/felangel/bloc/blob/master/packages/bloc/test/bloc_observer_test.dart.
void main() {
  final bloc = TodoBloc();
  final error = Exception();
  const stackTrace = StackTrace.empty;
  const event = AddTodoEvent;
  final change = Change(currentState: const [], nextState: [Item(description: 'description')]);
  final transition = Transition(
    currentState: const [],
    event: AddTodoEvent,
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
