import 'package:dwyl_app/blocs/blocs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dwyl_app/models/item.dart';

void main() {
  group('ItemEvent', () {
    group('ItemListStarted', () {
      test('supports value comparison', () {
        expect(ItemListStarted(), ItemListStarted());
      });
    });

    group('AddItemEvent', () {
      final item = Item(description: 'description');
      test('supports value comparison', () {
        expect(AddItemEvent(item), AddItemEvent(item));
      });
    });

    group('RemoveItemEvent', () {
      final item = Item(description: 'description');
      test('supports value comparison', () {
        expect(RemoveItemEvent(item), RemoveItemEvent(item));
      });
    });

    group('ToggleItemEvent', () {
      final item = Item(description: 'description');
      test('supports value comparison', () {
        expect(ToggleItemEvent(item), ToggleItemEvent(item));
      });
    });
  });
}
