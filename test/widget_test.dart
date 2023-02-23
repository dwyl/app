import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart';

void main() {
  testWidgets('Basic setup, showing the main page with appbar', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    expect(find.byKey(appBarKey).hitTestable(), findsOneWidget);
  });

  testWidgets('Expand textfield and tap save', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    expect(find.byKey(saveButtonKey).hitTestable(), findsNothing);

    // Tap on textfield
    await tester.tap(find.byKey(textfieldKey));
    await tester.pumpAndSettle();

    // Save button should be shown
    expect(find.byKey(saveButtonKey).hitTestable(), findsOneWidget);

    // Tap on save button
    await tester.tap(find.byKey(saveButtonKey));
    await tester.pumpAndSettle();

    expect(find.byKey(saveButtonKey).hitTestable(), findsNothing);
  });
}
