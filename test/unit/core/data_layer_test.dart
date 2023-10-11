
import 'package:dwyl_app/core/data_layer.dart';
import 'package:dwyl_app/data/repositories/image/image_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Creating data vault works, whilst looking and storing maps - release mode', () {
    final dataLayer = createDataLayer(isRelease: true);
    expect(dataLayer.lookup<ImageRepository>(), isA<ImageRepository>());
  });
}
