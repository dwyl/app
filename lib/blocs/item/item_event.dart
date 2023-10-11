part of 'item_bloc.dart';

sealed class ItemEvent extends Equatable {
  const ItemEvent();
}

/// Event to kick start the item list event
class ItemListStarted extends ItemEvent {
  @override
  List<Object> get props => [];
}

/// AddItem event when an item is added
class AddItemEvent extends ItemEvent {
  final Item itemObj;

  const AddItemEvent(this.itemObj);

  @override
  List<Object> get props => [itemObj];
}

/// RemoveItem event when an item is removed
class RemoveItemEvent extends ItemEvent {
  final Item itemObj;

  const RemoveItemEvent(this.itemObj);

  @override
  List<Object> get props => [itemObj];
}

/// ToggleItem event when an item is toggled
class ToggleItemEvent extends ItemEvent {
  final Item itemObj;

  const ToggleItemEvent(this.itemObj);

  @override
  List<Object> get props => [itemObj];
}
