import 'package:dwyl_app/blocs/blocs.dart';
import 'package:dwyl_app/core/core.dart';
import 'package:dwyl_app/presentation/views/views.dart';
import 'package:dwyl_app/presentation/widgets/editor/emoji_picker.dart';
import 'package:dwyl_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/flutter_quill_test.dart';
import 'package:flutter_quill_extensions/embeds/toolbar/image_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

class FakeImagePicker extends ImagePickerPlatform {
  @override
  Future<XFile?> getImageFromSource({
    required ImageSource source,
    ImagePickerOptions options = const ImagePickerOptions(),
  }) async {
    final data = await rootBundle.load('assets/sample.jpeg');
    final bytes = data.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final file = await File(
      '${tempDir.path}/doc.png',
    ).writeAsBytes(bytes);

    return XFile(file.path);
  }

  @override
  Future<List<XFile>> getMultiImageWithOptions({
    MultiImagePickerOptions options = const MultiImagePickerOptions(),
  }) async {
    final data = await rootBundle.load('assets/sample.jpeg');
    final bytes = data.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final file = await File(
      '${tempDir.path}/sample.png',
    ).writeAsBytes(bytes);
    return <XFile>[
      XFile(
        file.path,
      ),
    ];
  }
}

void main() {
  /// Bootstraps a sample main application, whether it [isWeb] or not.
  Widget initializeMainApp({required bool isWeb}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemBloc>(create: (context) => ItemBloc()..add(ItemListStarted())),
        BlocProvider<AppCubit>(create: (context) => AppCubit(isWeb: isWeb)),
      ],
      child: const MainApp(),
    );
  }

  // See https://stackoverflow.com/questions/76586920/mocking-imagepicker-in-flutter-integration-tests-not-working for context.
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    ImagePickerPlatform.instance = FakeImagePicker();
  });

  group('Normal build', () {
    testWidgets('is correctly setup and loaded.', (WidgetTester tester) async {
      final app = initializeMainApp(isWeb: false);
      await tester.pumpWidget(app);
      await tester.pump();

      // Find the text input and string stating 0 items created
      expect(find.byKey(textfieldKey), findsOneWidget);
    });
  });

  group('Adding a new item', () {
    testWidgets('shows a card', (WidgetTester tester) async {
      final app = initializeMainApp(isWeb: false);
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Find the text input and string stating 0 items created
      expect(find.byKey(textfieldKey), findsOneWidget);
      expect(find.byKey(itemCardWidgetKey), findsNothing);

      // Tap textfield to open new page to create item
      await tester.tap(find.byKey(textfieldKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final editor = find.byType(QuillEditor);

      // Type text into item editor
      await tester.tap(editor);
      await tester.quillEnterText(editor, 'Make lunch\n');
      await tester.pumpAndSettle();

      // Tap "Save" button to add new item
      await tester.tap(find.byKey(saveButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Pump the widget so it renders the new item
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Expect to find at least one widget, pertaining to the one that was added
      expect(find.byKey(itemCardWidgetKey), findsOneWidget);
    });

    testWidgets('shows a card (on mobile screen).', (WidgetTester tester) async {
      // Ensure binding is initialized to setup camera size
      TestWidgetsFlutterBinding.ensureInitialized();
      tester.view.physicalSize = const Size(400, 600);
      tester.view.devicePixelRatio = 1.0;

      final app = initializeMainApp(isWeb: false);
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Find the text input and string stating 0 items created
      expect(find.byKey(textfieldKey), findsOneWidget);
      expect(find.byKey(itemCardWidgetKey), findsNothing);

      // Tap textfield to open new page to create item
      await tester.tap(find.byKey(textfieldKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final editor = find.byType(QuillEditor);

      // Type text into item input
      await tester.tap(editor);
      await tester.quillEnterText(editor, 'Make lunch\n');
      await tester.pumpAndSettle();

      // Tap "Save" button to add new item
      await tester.tap(find.byKey(saveButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Pump the widget so it renders the new item
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Expect to find at least one widget, pertaining to the one that was added
      expect(find.byKey(itemCardWidgetKey), findsOneWidget);

      // Resetting camera size to normal
      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('shows a card (on tablet screen).', (WidgetTester tester) async {
      // Ensure binding is initialized to setup camera size
      TestWidgetsFlutterBinding.ensureInitialized();
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1.0;

      final app = initializeMainApp(isWeb: false);
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Find the text input and string stating 0 items created
      expect(find.byKey(textfieldKey), findsOneWidget);
      expect(find.byKey(itemCardWidgetKey), findsNothing);

      // Tap textfield to open new page to create item
      await tester.tap(find.byKey(textfieldKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final editor = find.byType(QuillEditor);

      // Type text into item input
      await tester.tap(editor);
      await tester.quillEnterText(editor, 'Make lunch\n');
      await tester.pumpAndSettle();

      // Tap "Save" button to add new item
      await tester.tap(find.byKey(saveButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Pump the widget so it renders the new item
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Expect to find at least one widget, pertaining to the one that was added
      expect(find.byKey(itemCardWidgetKey), findsOneWidget);

      // Resetting camera size to normal
      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('shows a card (on web platform).', (WidgetTester tester) async {
      // Ensure binding is initialized to setup camera size
      TestWidgetsFlutterBinding.ensureInitialized();
      tester.view.physicalSize = const Size(400, 600);
      tester.view.devicePixelRatio = 1.0;

      final app = initializeMainApp(isWeb: true);
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Find the text input and string stating 0 items created
      expect(find.byKey(textfieldKey), findsOneWidget);
      expect(find.byKey(itemCardWidgetKey), findsNothing);

      // Tap textfield to open new page to create item
      await tester.tap(find.byKey(textfieldKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final editor = find.byType(QuillEditor);

      // Type text into item input
      await tester.tap(editor);
      await tester.quillEnterText(editor, 'Make lunch\n');
      await tester.pumpAndSettle();

      // Tap "Save" button to add new item
      await tester.tap(find.byKey(saveButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Pump the widget so it renders the new item
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Expect to find at least one widget, pertaining to the one that was added
      expect(find.byKey(itemCardWidgetKey), findsOneWidget);

      // Resetting camera size to normal
      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('and checking it as done.', (WidgetTester tester) async {
      final app = initializeMainApp(isWeb: false);
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Find the text input and string stating 0 items created
      expect(find.byKey(textfieldKey), findsOneWidget);
      expect(find.byKey(itemCardWidgetKey), findsNothing);

      // Tap textfield to open new page to create item
      await tester.tap(find.byKey(textfieldKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Type text into item input and tap "Save" button to add new item
      final editor = find.byType(QuillEditor);

      await tester.tap(editor);
      await tester.quillEnterText(editor, 'Make lunch\n');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(saveButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Expect to find at least one widget, pertaining to the one that was added
      expect(find.byKey(itemCardWidgetKey), findsOneWidget);

      // Getting widget to test its value
      final checkboxFinder = find.descendant(
        of: find.byKey(itemCardWidgetKey),
        matching: find.byType(Icon),
      );
      var checkboxWidget = tester.firstWidget<Icon>(checkboxFinder);

      expect(checkboxWidget.icon, Icons.check_box_outline_blank);

      // Tap on item card
      await tester.tap(find.byKey(itemCardWidgetKey));
      await tester.pump(const Duration(seconds: 2));

      // Updating item card widget and checkbox value should be true
      checkboxWidget = tester.firstWidget<Icon>(checkboxFinder);
      expect(checkboxWidget.icon, Icons.check_box);
    });

    testWidgets('and clicking timer button and marking it as done while it\'s running.', (WidgetTester tester) async {
      final app = initializeMainApp(isWeb: false);
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Find the text input and string stating 0 items created
      expect(find.byKey(textfieldKey), findsOneWidget);
      expect(find.byKey(itemCardWidgetKey), findsNothing);

      // Tap textfield to open new page to create item
      await tester.tap(find.byKey(textfieldKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Type text into item input and tap "Save" button to add new item
      final editor = find.byType(QuillEditor);

      await tester.tap(editor);
      await tester.quillEnterText(editor, 'Make lunch\n');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(saveButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Expect to find at least one widget, pertaining to the one that was added
      expect(find.byKey(itemCardWidgetKey), findsOneWidget);

      // Getting widget to test its value
      var buttonWidget = tester.firstWidget<ElevatedButton>(find.byKey(itemCardTimerButtonKey));

      // Button should be stopped
      var buttonText = buttonWidget.child as Text;
      expect(buttonText.data, 'Start');

      // Tap on timer button.
      await tester.tap(find.byKey(itemCardTimerButtonKey));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Updating widget and button should be ongoing
      buttonWidget = tester.firstWidget<ElevatedButton>(find.byKey(itemCardTimerButtonKey));
      buttonText = buttonWidget.child as Text;
      expect(buttonText.data, 'Stop');

      // Tap on timer button AGAIN
      await tester.tap(find.byKey(itemCardTimerButtonKey));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Updating widget and button should be stopped
      buttonWidget = tester.firstWidget<ElevatedButton>(find.byKey(itemCardTimerButtonKey));
      buttonText = buttonWidget.child as Text;
      expect(buttonText.data, 'Resume');

      // Tap on timer button AGAIN x2
      await tester.tap(find.byKey(itemCardTimerButtonKey));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Updating widget and button should be ongoing
      buttonWidget = tester.firstWidget<ElevatedButton>(find.byKey(itemCardTimerButtonKey));
      buttonText = buttonWidget.child as Text;
      expect(buttonText.data, 'Stop');

      // Tap on item card while its ongoing
      await tester.tap(find.byKey(itemCardWidgetKey));
      await tester.pumpAndSettle();

      // Item card should be marked as done
      final checkboxFinder = find.descendant(
        of: find.byKey(itemCardWidgetKey),
        matching: find.byType(Icon),
      );
      var checkboxWidget = tester.firstWidget<Icon>(checkboxFinder);
      checkboxWidget = tester.firstWidget<Icon>(checkboxFinder);
      expect(checkboxWidget.icon, Icons.check_box);
    });
  });

  group('Emoji picker', () {
    testWidgets('should be shown when clicking in the emoji button.', (WidgetTester tester) async {
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

      // Find the text input and string stating 0 items created
      expect(find.byKey(textfieldKey), findsOneWidget);
      expect(find.byKey(itemCardWidgetKey), findsNothing);

      // Tap textfield to open new page to create item
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

    testWidgets('should lose focus of keyboard when double tapped', (WidgetTester tester) async {
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

      // Find the text input and string stating 0 items created
      expect(find.byKey(textfieldKey), findsOneWidget);
      expect(find.byKey(itemCardWidgetKey), findsNothing);

      // Tap textfield to open new page to create item
      await tester.tap(find.byKey(textfieldKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Expect to find the normal page setup and emoji picker not being shown
      final editor = find.byType(QuillEditor);
      expect(editor.hitTestable(), findsOneWidget);
      expect(find.byKey(emojiPickerWidgetKey).hitTestable(), findsNothing);

      // Tap on editor to gain focus
      await tester.tap(editor);
      await tester.pumpAndSettle();

      // Click on emoji button should show the emoji picker
      final emojiIcon = find.byIcon(Icons.emoji_emotions);
      await tester.tap(emojiIcon);
      await tester.pumpAndSettle();

      expect(find.byKey(emojiPickerWidgetKey).hitTestable(), findsOneWidget);
    });
  });

  group('Image picker', () {
    testWidgets('should show and select image', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      final app = initializeMainApp(isWeb: false);
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Tap textfield to open new page to create item
      await tester.tap(find.byKey(textfieldKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Should show editor and toolbar
      final editor = find.byType(QuillEditor);
      final toolbar = find.byType(QuillToolbar);
      expect(editor.hitTestable(), findsOneWidget);
      expect(toolbar.hitTestable(), findsOneWidget);

      // Drag toolbar to the right
      await tester.drag(toolbar, const Offset(-500, 0));
      await tester.pump(const Duration(minutes: 1));

      // Press image button
      // Because of the override, should embed image.
      final imageButton = find.byType(ImageButton);
      await tester.tap(imageButton);
      await tester.pumpAndSettle();

      // Image correctly added, editor should be visible again.
      expect(editor.hitTestable(), findsOneWidget);
    });


    // TODO does not work because inside ImageButton, there is a `kIsWeb`. 
    // This can't be mockable, unless we use a custom button to recreate this behaviour.
    testWidgets('should show and select image (on the web - uploads image to the web)', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      final app = initializeMainApp(isWeb: true);
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Tap textfield to open new page to create item
      await tester.tap(find.byKey(textfieldKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Should show editor and toolbar
      final editor = find.byType(QuillEditor);
      final toolbar = find.byType(QuillToolbar);
      expect(editor.hitTestable(), findsOneWidget);
      expect(toolbar.hitTestable(), findsOneWidget);

      // Drag toolbar to the right
      await tester.drag(toolbar, const Offset(-500, 0));
      await tester.pump(const Duration(minutes: 1));

      // Press image button
      // Because of the override, should embed image.
      final imageButton = find.byType(ImageButton);
      await tester.tap(imageButton);
      await tester.pumpAndSettle();

      // Image correctly added, editor should be visible again.
      expect(editor.hitTestable(), findsOneWidget);
    });
  });

  group('Navigation', () {
    testWidgets('from the new item page and go back.', (WidgetTester tester) async {
      final app = initializeMainApp(isWeb: false);
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Find the text input and string stating 0 items created
      expect(find.byKey(textfieldKey), findsOneWidget);
      expect(find.byKey(itemCardWidgetKey), findsNothing);

      // Tap textfield to open new page to create item
      await tester.tap(find.byKey(textfieldKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Go back to the page
      expect(find.byKey(textfieldKey), findsNothing);

      await tester.tap(find.byKey(backButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // User went back to the home page
      expect(find.byKey(textfieldKey), findsOneWidget);

      // Tap textfield again to open new page to create item
      await tester.tap(find.byKey(textfieldKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tap on the logo icon. Person should go back.
      await tester.tap(find.byKey(logoKey));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // User went back to the home page
      expect(find.byKey(textfieldKey), findsOneWidget);
    });
  });
}
