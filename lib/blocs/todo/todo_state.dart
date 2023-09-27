part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();
}

/// Initial TodoBloc state
class TodoInitialState extends TodoState {
  @override
  List<Object> get props => [];
}

/// TodoBloc state when the todo item list is loaded
class TodoListLoadedState extends TodoState {
  final List<Item> items;
  const TodoListLoadedState({this.items = const []});
  @override
  List<Object> get props => [items];
}

/// TodoBloc state when a todo item errors when loading
class TodoListErrorState extends TodoState {
  @override
  List<Object> get props => [];
}
