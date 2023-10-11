import 'package:dwyl_app/blocs/data/data_cubit.dart';
import 'package:dwyl_app/data/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('DataCubit', () {
    group('DataInitial', () {
      test('supports value comparison', () {
        expect(DataInitial(ImgupRepository(client: http.Client())).props, DataInitial(ImgupRepository(client: http.Client())).props);
      });
    });
  });
}
