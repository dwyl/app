import 'dart:typed_data';

import 'package:dwyl_app/data/repositories/image/image_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('ImageRepository should yield results on a successful request (these make a REAL request)', () async {
    final imageRepository = ImgupRepository(client: http.Client());

    // Byte array from number byte array https://gist.github.com/leommoore/f9e57ba2aa4bf197ebc5.
    final bytes = Uint8List.fromList([0xff, 0xd8, 0xff, 0xe0]);

    // Should return an URL, not an error.
    final ret = await imageRepository.uploadImage(bytes, 'cool_birthday');
    expect(ret.isRight(), true);
  });

  test('ImageRepository should yield an error because bytes array is empty.', () async {
    final imageRepository = ImgupRepository(client: http.Client());

    final bytes = Uint8List.fromList([]);

    // Should error out
    final ret = await imageRepository.uploadImage(bytes, 'cool_birthday');
    expect(ret.isLeft(), true);
  });

  test('ImageRepository should yield an error because bytes array has invalid mimetype', () async {
    final imageRepository = ImgupRepository(client: http.Client());

    // Invalid byte array (a simple [0] does not have any mime type)
    final bytes = Uint8List.fromList([0]);

    // Should error out
    final ret = await imageRepository.uploadImage(bytes, 'cool_birthday');
    expect(ret.isLeft(), true);
  });
}
