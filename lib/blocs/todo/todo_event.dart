part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

/// Event to kick start the todo list event
class TodoListStarted extends TodoEvent {
  @override
  List<Object> get props => [];
}

/// AddTodo event when an item is added
class AddTodoEvent extends TodoEvent {
  final Item todoObj;

  const AddTodoEvent(this.todoObj);

  @override
  List<Object> get props => [todoObj];
}

/// RemoveTodo event when an item is removed
class RemoveTodoEvent extends TodoEvent {
  final Item todoObj;

  const RemoveTodoEvent(this.todoObj);

  @override
  List<Object> get props => [todoObj];
}

/// RemoveTodo event when an item is toggled
class ToggleTodoEvent extends TodoEvent {
  final Item todoObj;

  const ToggleTodoEvent(this.todoObj);

  @override
  List<Object> get props => [todoObj];
}
