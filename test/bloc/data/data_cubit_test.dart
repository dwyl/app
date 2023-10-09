import 'package:bloc_test/bloc_test.dart';
import 'package:dwyl_app/blocs/data/data_cubit.dart';
import 'package:dwyl_app/data/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('DataCubit', () {
    blocTest(
      'emits [] on initial setup',
      build: () => DataCubit(imageRepository: ImgupRepository(client: http.Client())),
      expect: () => [],
    );
  });
}
