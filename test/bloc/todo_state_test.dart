import 'package:flutter_test/flutter_test.dart';
import 'package:dwyl_todo/blocs/blocs.dart';

void main() {
  group('TodoState', () {
    group('TodoInitialState', () {
      test('supports value comparison', () {
        expect(TodoInitialState(), TodoInitialState());
      });
    });

    group('TodoListLoadedState', () {
      test('supports value comparison', () {
        expect(const TodoListLoadedState(), const TodoListLoadedState());
      });
    });

    group('TodoListErrorState', () {
      test('supports value comparison', () {
        expect(TodoListErrorState(), TodoListErrorState());
      });
    });
  });
}
