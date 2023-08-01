import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/item.dart';

part 'todo_event.dart';
part 'todo_state.dart';

/// This is the TodoBloc,
/// the bloc that manages the list of todos.
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // Bloc constructor and adding event handlers
  TodoBloc() : super(TodoInitialState()) {
    on<TodoListStarted>(_onStart);
    on<AddTodoEvent>(_addTodo);
    on<RemoveTodoEvent>(_removeTodo);
    on<ToggleTodoEvent>(_toggleTodo);
  }

  void _onStart(TodoListStarted event, Emitter<TodoState> emit) {
    // You could do stuff here like:
    // 1. emit "loading state"
    // 2. fetch todos from API
    // 3. emit "success state" or "error state"

    emit(const TodoListLoadedState(items: []));
  }

  // AddTodo event handler which emits TodoAdded state
  void _addTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;

    // Check if list is loaded
    if (state is TodoListLoadedState) {
      emit(TodoListLoadedState(items: [...state.items, event.todoObj]));
    }
  }

  // RemoveTodo event handler which emits TodoDeleted state
  void _removeTodo(RemoveTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;

    // Check if list is loaded
    if (state is TodoListLoadedState) {
      var items = state.items;
      items.removeWhere((element) => element.id == event.todoObj.id);

      emit(TodoListLoadedState(items: items));
    }
  }

  // ToggleTodo event handler which emits a TodoToggled state
  void _toggleTodo(ToggleTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;

    // Check if list is loaded
    if (state is TodoListLoadedState) {
      // You have to create a new object because the items list needs to be new so Bloc knows it needs to re-render
      // https://stackoverflow.com/questions/65379743/flutter-bloc-cant-update-my-list-of-boolean
      var items = List<Item>.from(state.items);
      var indexToChange =
          items.indexWhere((element) => element.id == event.todoObj.id);

      // If the element is found, we create a copy of the element with the `completed` field toggled.
      if (indexToChange != -1) {
        var itemToChange = items[indexToChange];
        var updatedItem = Item(
            description: itemToChange.description,
            completed: !itemToChange.completed);

        items[indexToChange] = updatedItem;
      }

      emit(TodoListLoadedState(items: [...items]));
    }
  }
}
