import 'package:dwyl_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:responsive_framework/responsive_framework.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';

const saveButtonKey = Key('saveButtonKey');
const newItemPageNavbarKey = Key('newItemPageNavbarKey');

/// Transition handler that navigates the route to the `NewTodo` item page.
Route navigateToCreateNewItemPage() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const NewItemPage(),
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );
}

/// Page that shows a textfield expanded to create a new item.
class NewItemPage extends StatefulWidget {
  const NewItemPage({super.key});

  @override
  State<NewItemPage> createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  final _controller = QuillController(
    document: Document(),
    selection: const TextSelection.collapsed(offset: 0),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Dismisses the keyboard when the user taps on the navbar.
  ///
  /// See https://flutterigniter.com/dismiss-keyboard-form-lose-focus/ for more implementation details.
  void _onTapNavbar(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = BlocProvider.of<AppCubit>(context).state.isWeb;

    return Scaffold(
      appBar: NavBar(
        key: newItemPageNavbarKey,
        givenContext: context,
        showGoBackButton: true,
        onTap: () => _onTapNavbar(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Textfield that is expanded and borderless
            Expanded(
              child: DeltaTodoEditor(
                isWeb: isWeb,
                editorController: _controller,
              ),
            ),

            // Save button.
            // When submitted, it adds a new item, clears the controller and navigates back
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                key: saveButtonKey,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 75, 192, 169),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: () {
                  final document = _controller.document;
                  var text = document.toPlainText();

                  // Remove last newline from text (document.toPlainText() adds this at the end of the text)
                  if (text.isNotEmpty) {
                    final lastChar = text[text.length - 1];
                    text = lastChar == '\n' ? text.substring(0, text.length - 1) : text;
                  }

                  if (text.isNotEmpty) {
                    // Create new item and create AddTodo event
                    final newTodoItem = Item(description: text, document: document);
                    BlocProvider.of<ItemBloc>(context).add(AddItemEvent(newTodoItem));

                    // Clear textfield
                    _controller.clear();

                    // Go back to home page
                    Navigator.pop(context);
                  }
                },
                child: SizedBox(
                  child: (() {
                    // On mobile
                    if (ResponsiveBreakpoints.of(context).isMobile) {
                      return const Text(
                        'Save',
                        style: TextStyle(fontSize: 24),
                      );
                    }

                    // On tablet and up
                    else {
                      return const Text(
                        'Save',
                        style: TextStyle(fontSize: 40),
                      );
                    }
                  }()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
