import 'package:app/menu.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart';

void main() {
  testWidgets('Open drawer and close it', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Appbar is rendered
    expect(find.byKey(appBarKey).hitTestable(), findsOneWidget);
    expect(find.byKey(drawerMenuKey).hitTestable(), findsNothing);

    await tester.tap(find.byKey(iconKey));
    await tester.pumpAndSettle();

    // Expect drawer menu to be shown
    expect(find.byKey(drawerMenuKey).hitTestable(), findsOneWidget);

    await tester.tap(find.byKey(closeMenuKey));
    await tester.pumpAndSettle();

    // Expect drawer menu to be closed
    expect(find.byKey(drawerMenuKey).hitTestable(), findsNothing);
  });
}
