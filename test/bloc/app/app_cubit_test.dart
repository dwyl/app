import 'package:bloc_test/bloc_test.dart';
import 'package:dwyl_app/blocs/blocs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppCubit', () {
    blocTest(
      'emits [] on initial setup',
      build: () => AppCubit(isWeb: true),
      expect: () => [],
    );
  });
}
