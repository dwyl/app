import 'package:dwyl_app/blocs/cubit/app_cubit.dart';
import 'package:dwyl_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';
import '../widgets/navbar.dart';

const textfieldOnNewPageKey = Key('textfieldOnNewPageKey');
const saveButtonKey = Key('saveButtonKey');

/// Transition handler that navigates the route to the `NewTodo` item page.
Route navigateToNewTodoItemPage() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const NewTodoPage(),
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );
}

/// Page that shows a textfield expanded to create a new todo item.
class NewTodoPage extends StatefulWidget {
  const NewTodoPage({super.key});

  @override
  State<NewTodoPage> createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  // https://stackoverflow.com/questions/61425969/is-it-okay-to-use-texteditingcontroller-in-statelesswidget-in-flutter
  TextEditingController txtFieldController = TextEditingController();

  @override
  void dispose() {
    txtFieldController.dispose();
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

    return MaterialApp(
      home: Scaffold(
        appBar: NavBar(
          givenContext: context,
          showGoBackButton: true,
          onTap: () => _onTapNavbar(context),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Textfield that is expanded and borderless
              Expanded(child: DeltaTodoEditor(isWeb: isWeb)),

              // Save button.
              // When submitted, it adds a new todo item, clears the controller and navigates back
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
                    final value = txtFieldController.text;
                    if (value.isNotEmpty) {
                      // Create new item and create AddTodo event
                      final newTodoItem = Item(description: value);
                      BlocProvider.of<TodoBloc>(context).add(AddTodoEvent(newTodoItem));

                      // Clear textfield
                      txtFieldController.clear();

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
      ),
    );
  }
}
