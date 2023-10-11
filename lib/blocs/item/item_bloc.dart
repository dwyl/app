import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/item.dart';

part 'item_event.dart';
part 'item_state.dart';

/// This is the ItemBloc,
/// the bloc that manages the list of items.
class ItemBloc extends Bloc<ItemEvent, ItemState> {
  // Bloc constructor and adding event handlers
  ItemBloc() : super(ItemInitialState()) {
    on<ItemListStarted>(_onStart);
    on<AddItemEvent>(_addItem);
    on<RemoveItemEvent>(_removeItem);
    on<ToggleItemEvent>(_toggleItem);
  }

  void _onStart(ItemListStarted event, Emitter<ItemState> emit) {
    // You could do stuff here like:
    // 1. emit "loading state"
    // 2. fetch items from API
    // 3. emit "success state" or "error state"

    emit(const ItemListLoadedState(items: []));
  }

  // AddItem event handler which emits ItemAdded state
  void _addItem(AddItemEvent event, Emitter<ItemState> emit) {
    final state = this.state;

    // Check if list is loaded
    if (state is ItemListLoadedState) {
      emit(ItemListLoadedState(items: [...state.items, event.itemObj]));
    }
  }

  // RemoveItem event handler which emits ItemDeleted state
  void _removeItem(RemoveItemEvent event, Emitter<ItemState> emit) {
    final state = this.state;

    // Check if list is loaded
    if (state is ItemListLoadedState) {
      final items = state.items;
      items.removeWhere((element) => element.id == event.itemObj.id);

      emit(ItemListLoadedState(items: items));
    }
  }

  // ToggleItem event handler which emits a ItemToggled state
  void _toggleItem(ToggleItemEvent event, Emitter<ItemState> emit) {
    final state = this.state;

    // Check if list is loaded
    if (state is ItemListLoadedState) {
      // You have to create a new object because the items list needs to be new so Bloc knows it needs to re-render
      // https://stackoverflow.com/questions/65379743/flutter-bloc-cant-update-my-list-of-boolean
      final items = List<Item>.from(state.items);
      final indexToChange = items.indexWhere((element) => element.id == event.itemObj.id);

      // If the element is found, we create a copy of the element with the `completed` field toggled.
      if (indexToChange != -1) {
        final itemToChange = items[indexToChange];
        final updatedItem = Item(
          description: itemToChange.description,
          completed: !itemToChange.completed,
        );

        items[indexToChange] = updatedItem;
      }

      emit(ItemListLoadedState(items: [...items]));
    }
  }
}
