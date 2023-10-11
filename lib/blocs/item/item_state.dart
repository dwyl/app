part of 'item_bloc.dart';

sealed class ItemState extends Equatable {
  const ItemState();
}

/// Initial ItemBloc state
class ItemInitialState extends ItemState {
  @override
  List<Object> get props => [];
}

/// ItemBloc state when the item list is loaded
class ItemListLoadedState extends ItemState {
  final List<Item> items;
  const ItemListLoadedState({this.items = const []});
  @override
  List<Object> get props => [items];
}

/// ItemBloc state when an item errors when loading
class ItemListErrorState extends ItemState {
  @override
  List<Object> get props => [];
}
