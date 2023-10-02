import 'package:flutter_test/flutter_test.dart';
import 'package:dwyl_app/blocs/blocs.dart';

void main() {
  group('AppCubit', () {
    group('AppInitial', () {
      test('supports value comparison', () {
        expect(const AppInitial(isWeb: true).props, const AppInitial(isWeb: true).props);
      });
    });
  });
}
