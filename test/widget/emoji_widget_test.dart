import 'package:dwyl_app/blocs/blocs.dart';
import 'package:dwyl_app/main.dart';
import 'package:dwyl_app/presentation/views/views.dart';
import 'package:dwyl_app/presentation/widgets/editor/emoji_picker.dart';
import 'package:dwyl_app/presentation/widgets/widgets.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  /// Bootstraps a `OffstageEmojiPicker`.
  Widget initializeOffstageEmojiPicker({required bool isWeb, required bool isOffstage}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemBloc>(create: (context) => ItemBloc()..add(ItemListStarted())),
        BlocProvider<AppCubit>(create: (context) => AppCubit(isWeb: isWeb)),
      ],
      child: MaterialApp(
        home: OffstageEmojiPicker(
          offstageEmojiPicker: isOffstage,
        ),
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

  /// Check for context: https://stackoverflow.com/questions/60671728/unable-to-load-assets-in-flutter-tests
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Emoji Picker', () {
    testWidgets('should be shown and tap on emoji.', (WidgetTester tester) async {
      // Initialize widget that should show picker
      final app = initializeOffstageEmojiPicker(isWeb: false, isOffstage: false);
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      expect(find.byType(EmojiPicker), findsOneWidget);

      // Tap on emoji
      final emoji = find.text('😍');
      await tester.tap(emoji);
      await tester.pumpAndSettle();

      expect(find.byType(EmojiPicker), findsOneWidget);
    });
  });
}
