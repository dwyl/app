
import 'package:dwyl_app/models/errors/errors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('RequestError defining.', () {
    const description = 'Error description';

    final item = RequestError(code: 400, description: description);

    // Checking attributes
    expect(item.description, description);
  });
}
