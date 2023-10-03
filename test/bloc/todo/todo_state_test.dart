import 'package:flutter_test/flutter_test.dart';
import 'package:dwyl_app/blocs/blocs.dart';

void main() {
  group('ItemState', () {
    group('ItemInitialState', () {
      test('supports value comparison', () {
        expect(ItemInitialState(), ItemInitialState());
      });
    });

    group('ItemListLoadedState', () {
      test('supports value comparison', () {
        expect(const ItemListLoadedState(), const ItemListLoadedState());
      });
    });

    group('ItemListErrorState', () {
      test('supports value comparison', () {
        expect(ItemListErrorState(), ItemListErrorState());
      });
    });
  });
}
