import 'package:dwyl_app/blocs/blocs.dart';
import 'package:dwyl_app/presentation/views/views.dart';
import 'package:dwyl_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/flutter_quill_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dwyl_app/main.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  /// Bootstraps a `NewItemPage`.
  Widget initializeNewItemPage({required bool isWeb}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemBloc>(create: (context) => ItemBloc()..add(ItemListStarted())),
        BlocProvider<AppCubit>(create: (context) => AppCubit(isWeb: isWeb)),
      ],
      child: MaterialApp(
        home: const NewItemPage(),
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 425, name: MOBILE),
            const Breakpoint(start: 426, end: 768, name: TABLET),
            const Breakpoint(start: 769, end: 1024, name: DESKTOP),
            const Breakpoint(start: 1025, end: 1440, name: 'LARGE_DESKTOP'),
            const Breakpoint(start: 1441, end: double.infinity, name: '4K'),
          ],
        ),
      ),
    );
  }

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('New item page', () {
    testWidgets('should lose focus when clicking on navbar.', (WidgetTester tester) async {
      final app = initializeNewItemPage(isWeb: false);

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Check if the editor is visible and tap it
      final editor = find.byType(QuillEditor);
      expect(editor.hitTestable(), findsOneWidget);

      await tester.tap(editor);
      await tester.pumpAndSettle();

      // Tap on navbar
      final navbar = find.byKey(newItemPageNavbarKey);
      await tester.tap(navbar);
      await tester.pumpAndSettle();

      expect(editor.hitTestable(), findsOneWidget);
    });
  });
}
