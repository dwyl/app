import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart';

void main() {
  testWidgets('Basic setup, showing the main page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text('DWYL'), findsOneWidget);
  });
}
