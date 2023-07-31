import 'package:bloc_test/bloc_test.dart';
import 'package:dwyl_todo/bloc/todo_bloc.dart';
import 'package:dwyl_todo/models/item.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('TodoBloc', () {
    // List of items to mock
    Item newItem = Item(description: "todo description");

    blocTest(
      'emits [] when nothing is added',
      build: () => TodoBloc(),
      expect: () => [],
    );

    blocTest(
      'emits [TodoListLoadedState] when AddTodoEvent is created',
      build: () => TodoBloc()..add(TodoListStarted()),
      act: (bloc) {
        bloc.add(AddTodoEvent(newItem));
      },
      expect: () => <TodoState>[
        const TodoListLoadedState(items: []), // when the todo bloc was loaded
        TodoListLoadedState(
            items: [newItem]) // when the todo bloc was added an event
      ],
    );

    blocTest(
      'emits [TodoListLoadedState] when RemoveTodoEvent is created',
      build: () => TodoBloc()..add(TodoListStarted()),
      act: (bloc) {
        Item newItem = Item(description: "todo description");
        bloc
          ..add(AddTodoEvent(newItem))
          ..add(RemoveTodoEvent(newItem)); // add and remove
      },
      expect: () => <TodoState>[
        const TodoListLoadedState(items: []),
        const TodoListLoadedState(items: [])
      ],
    );

    blocTest(
      'emits [TodoListLoadedState] when ToggleTodoEvent is created',
      build: () => TodoBloc()..add(TodoListStarted()),
      act: (bloc) {
        Item newItem = Item(description: "todo description");
        bloc
          ..add(AddTodoEvent(newItem))
          ..add(ToggleTodoEvent(newItem));
      },
      expect: () => [
        isA<TodoListLoadedState>(),
        isA<TodoListLoadedState>()
            .having((obj) => obj.items.first.completed, 'completed', false),
        isA<TodoListLoadedState>()
            .having((obj) => obj.items.first.completed, 'completed', true)
      ],
    );
  });
}
