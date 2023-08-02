import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'blocs/blocs.dart';
import 'models/models.dart';
import 'presentation/widgets/widgets.dart';


// Keys used for testing
const textfieldKey = Key("textfieldKey");
const textfieldOnNewPageKey = Key('textfieldOnNewPageKey');
const saveButtonKey = Key('saveButtonKey');


// coverage:ignore-start
void main() {
  runApp(const MainApp());
}
// coverage:ignore-end

/// The main class of the app.
/// It will create the state manager with `BlocProvider` and make it available along the widget tree.
///
/// The `TodoListStarted` event is instantly spawned when the app starts.
/// This is because we've yet have the need to fetch information from third-party APIs before initializing the app.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc()..add(TodoListStarted()),
      child: MaterialApp(
        home: const HomePage(),
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
}

/// App's home page.
/// The person will be able to create a new todo item
/// and view a list of previously created ones.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top navigation bar
      appBar: NavBar(
        givenContext: context,
      ),

      // Body of the page.
      // It is responsive and change style according to the device.
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          // If the list is loaded
          if (state is TodoListLoadedState) {
            var items = state.items;

            return SafeArea(
              child: Column(
                children: [
                  Container(
                    child: (() {
                      // On mobile
                      if (ResponsiveBreakpoints.of(context).isMobile) {
                        return TextField(
                          key: textfieldKey,
                          controller: TextEditingController(),
                          keyboardType: TextInputType.none,
                          onTap: () {
                            Navigator.of(context)
                                .push(navigateToNewTodoItemPage());
                          },
                          maxLines: 2,
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            hintText: 'Capture more things on your mind...',
                          ),
                          textAlignVertical: TextAlignVertical.top,
                        );
                      }

                      // On tablet and up
                      else {
                        return TextField(
                          key: textfieldKey,
                          controller: TextEditingController(),
                          keyboardType: TextInputType.none,
                          onTap: () {
                            Navigator.of(context)
                                .push(navigateToNewTodoItemPage());
                          },
                          maxLines: 2,
                          style: const TextStyle(fontSize: 30),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            hintText: 'Capture more things on your mind...',
                          ),
                          textAlignVertical: TextAlignVertical.top,
                        );
                      }
                    }()),
                  ),

                  // List of items
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(top: 40),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        if (items.isNotEmpty) const Divider(height: 0),
                        for (var i = 0; i < items.length; i++) ...[
                          if (i > 0) const Divider(height: 0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ItemCard(item: items[i]),
                          )
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          // If the state of the TodoItemList is not loaded, we show error.ˆ
          else {
            return const Center(child: Text("Error loading items list."));
          }
        },
      ),
    );
  }
}

// PAGES ----------------------------

/// Transition handler that navigates the route to the `NewTodo` item page.
Route navigateToNewTodoItemPage() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const NewTodoPage(),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: NavBar(
          givenContext: context,
          showGoBackButton: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Textfield that is expanded and borderless
              Expanded(
                child: (() {
                  // On mobile
                  if (ResponsiveBreakpoints.of(context).isMobile) {
                    return TextField(
                      key: textfieldOnNewPageKey,
                      controller: txtFieldController,
                      expands: true,
                      maxLines: null,
                      autofocus: true,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        hintText: 'start typing',
                      ),
                      textAlignVertical: TextAlignVertical.top,
                    );
                  }

                  // On tablet and up
                  else {
                    return TextField(
                      key: textfieldOnNewPageKey,
                      controller: txtFieldController,
                      expands: true,
                      maxLines: null,
                      autofocus: true,
                      style: const TextStyle(fontSize: 30),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        hintText: 'start typing',
                      ),
                      textAlignVertical: TextAlignVertical.top,
                    );
                  }
                }()),
              ),

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
                      var newTodoItem = Item(description: value);
                      BlocProvider.of<TodoBloc>(context)
                          .add(AddTodoEvent(newTodoItem));

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
