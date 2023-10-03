import 'package:bloc_test/bloc_test.dart';
import 'package:dwyl_app/blocs/blocs.dart';
import 'package:dwyl_app/models/item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ItemBloc', () {
    // List of items to mock
    final newItem = Item(description: 'Item description');

    blocTest(
      'emits [] when nothing is added',
      build: () => ItemBloc(),
      expect: () => [],
    );

    blocTest(
      'emits [ItemListLoadedState] when AddItemEvent is created',
      build: () => ItemBloc()..add(ItemListStarted()),
      act: (bloc) {
        bloc.add(AddItemEvent(newItem));
      },
      expect: () => <ItemState>[
        const ItemListLoadedState(items: []), // when the item bloc was loaded
        ItemListLoadedState(
          items: [newItem],
        ), // when the item bloc was added an event
      ],
    );

    blocTest(
      'emits [ItemListLoadedState] when RemoveItemEvent is created',
      build: () => ItemBloc()..add(ItemListStarted()),
      act: (bloc) {
        final newItem = Item(description: 'Item description');
        bloc
          ..add(AddItemEvent(newItem))
          ..add(RemoveItemEvent(newItem)); // add and remove
      },
      expect: () => <ItemState>[const ItemListLoadedState(items: []), const ItemListLoadedState(items: [])],
    );

    blocTest(
      'emits [ItemListLoadedState] when ToggleItemEvent is created',
      build: () => ItemBloc()..add(ItemListStarted()),
      act: (bloc) {
        final newItem = Item(description: 'Item description');
        bloc
          ..add(AddItemEvent(newItem))
          ..add(ToggleItemEvent(newItem));
      },
      expect: () => [
        isA<ItemListLoadedState>(),
        isA<ItemListLoadedState>().having((obj) => obj.items.first.completed, 'completed', false),
        isA<ItemListLoadedState>().having((obj) => obj.items.first.completed, 'completed', true),
      ],
    );
  });
}
