
import 'package:dwyl_app/blocs/blocs.dart';
import 'package:dwyl_app/main.dart';
import 'package:dwyl_app/presentation/views/views.dart';
import 'package:dwyl_app/presentation/widgets/editor/emoji_picker.dart';
import 'package:dwyl_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {

  /// Bootstraps a sample main application, whether it [isWeb] or not.
  Widget initializeMainApp({required bool isWeb}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(create: (context) => TodoBloc()..add(TodoListStarted())),
        BlocProvider<AppCubit>(create: (context) => AppCubit(isWeb: isWeb)),
      ],
      child: const MainApp(),
    );
  }

  /// Check for context: https://stackoverflow.com/questions/60671728/unable-to-load-assets-in-flutter-tests
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('Click on emoji button should show the emoji picker', (WidgetTester tester) async {
    // Set size because it's needed to correctly tap on emoji picker
    // and ensure binding is initialized to setup camera size
    TestWidgetsFlutterBinding.ensureInitialized();
    tester.view.physicalSize = const Size(380, 800);
    tester.view.devicePixelRatio = 1.0;
    await tester.binding.setSurfaceSize(const Size(380, 800));

    // Initialize app
    final app = initializeMainApp(isWeb: false);
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    // Find the text input and string stating 0 todos created
    expect(find.byKey(textfieldKey), findsOneWidget);
    expect(find.byKey(itemCardWidgetKey), findsNothing);

    // Tap textfield to open new page to create todo item
    await tester.tap(find.byKey(textfieldKey));
    await tester.pumpAndSettle(const Duration(seconds: 2));


    // Expect to find the normal page setup and emoji picker not being shown
    final editor = find.byType(QuillEditor);
    expect(editor.hitTestable(), findsOneWidget);
    expect(find.byKey(emojiPickerWidgetKey).hitTestable(), findsNothing);

    // Click on emoji button should show the emoji picker
    var emojiIcon = find.byIcon(Icons.emoji_emotions);

    await tester.tap(emojiIcon);
    await tester.pumpAndSettle();

    emojiIcon = find.byIcon(Icons.emoji_emotions);

    // Expect the emoji picker being shown
    expect(find.byKey(emojiButtonKey).hitTestable(), findsOneWidget);

    // Tap on smile category
    await tester.tapAt(const Offset(61, 580));
    await tester.pumpAndSettle();

    // Tap on smile icon
    await tester.tapAt(const Offset(14, 632));
    await tester.pumpAndSettle();

    // Tap on emoji icon to close the emoji pickers
    emojiIcon = find.byIcon(Icons.emoji_emotions);

    await tester.tap(emojiIcon);
    await tester.pumpAndSettle();

    expect(find.byKey(emojiPickerWidgetKey).hitTestable(), findsNothing);
  });
}
