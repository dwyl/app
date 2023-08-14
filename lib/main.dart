import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'bloc/todo_bloc.dart';
import 'models/item.dart';
import 'models/stopwatch.dart';

// Keys used for testing
const textfieldKey = Key('textfieldKey');
const textfieldOnNewPageKey = Key('textfieldOnNewPageKey');
const saveButtonKey = Key('saveButtonKey');
const itemCardWidgetKey = Key('itemCardWidgetKey');
const itemCardTimerButtonKey = Key('itemCardTimerButtonKey');
const backButtonKey = Key('backButtonKey');
const logoKey = Key('logoKey');

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
      appBar: NavigationBar(
        givenContext: context,
      ),

      // Body of the page.
      // It is responsive and change style according to the device.
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          // If the list is loaded
          if (state is TodoListLoadedState) {
            final items = state.items;

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
            return const Center(child: Text('Error loading items list.'));
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
        appBar: NavigationBar(
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
                      final newTodoItem = Item(description: value);
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

// WIDGETS --------------------------

/// Navigation bar widget.
/// It needs to receive a context to dynamically elements.
class NavigationBar extends StatelessWidget implements PreferredSizeWidget {
  // Boolean that tells the bar to have a button to go to the previous page
  final bool showGoBackButton;
  // Build context for the "go back" button works
  final BuildContext givenContext;

  const NavigationBar({
    required this.givenContext, super.key,
    this.showGoBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(givenContext);
            },
            child:
                // dwyl logo
                Image.asset(
              'assets/icon/icon.png',
              key: logoKey,
              fit: BoxFit.fitHeight,
              height: 30,
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 81, 72, 72),
      elevation: 0.0,
      centerTitle: true,
      leading: showGoBackButton
          ? BackButton(
              key: backButtonKey,
              onPressed: () {
                Navigator.pop(givenContext);
              },
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

/// Widget pertaining to an item card.
/// It shows its info and changes state according to its progress.
class ItemCard extends StatefulWidget {
  final Item item;

  const ItemCard({required this.item, super.key});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  // Timer to be displayed
  late TimerStopwatch _stopwatch;

  // Used to re-render the text showing the timer
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    _stopwatch =
        TimerStopwatch(initialOffset: widget.item.getCumulativeDuration());

    // Timer to rerender the page so the text shows the seconds passing by
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {});
      }
    });
  }

  // Timer needs to be disposed when widget is destroyed to avoid memory leaks
  // https://stackoverflow.com/questions/42448410/how-can-i-run-a-unit-test-when-the-tapped-widget-launches-a-timer
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Formats milliseconds to human-readable time
  // https://itnext.io/create-a-stopwatch-app-with-flutter-f0dc6a176b8a
  String formatTime(int milliseconds) {
    final secs = milliseconds ~/ 1000;
    final hours = (secs ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (secs % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  // Start and stop timer button handler
  void _handleButtonClick() {
    // If timer is ongoing, we stop the stopwatch and the timer in the todo item.
    if (_stopwatch.isRunning) {
      widget.item.stopTimer();
      _stopwatch.stop();

      // Re-render
      setState(() {});
    }

    // If we are to start timer, start the timer in todo item and stopwatch.
    else {
      widget.item.startTimer();
      _stopwatch.start();

      // Re-render
      setState(() {});
    }
  }

  // Set proper background to timer button according to status of stopwatch
  Color _renderButtonBackground() {
    if (_stopwatch.elapsedMilliseconds == 0) {
      return const Color.fromARGB(255, 75, 192, 169);
    } else {
      return _stopwatch.isRunning ? Colors.red : Colors.green;
    }
  }

  // Set button text according to status of stopwatch
  String _renderButtonText() {
    if (_stopwatch.elapsedMilliseconds == 0) {
      return 'Start';
    } else {
      return _stopwatch.isRunning ? 'Stop' : 'Resume';
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final checkboxSize = deviceWidth > 425.0 ? 30.0 : 20.0;

    return Container(
      key: itemCardWidgetKey,
      constraints: const BoxConstraints(minHeight: 70),
      child: ListTile(
        onTap: () {
          // If the stopwatch is not running, we mark toggle it
          if (!_stopwatch.isRunning) {
            context.read<TodoBloc>().add(ToggleTodoEvent(widget.item));
          }

          // If the stopwatch is running, we toggle the item but also stop the timer
          else {
            context.read<TodoBloc>().add(ToggleTodoEvent(widget.item));
            widget.item.stopTimer();
            _stopwatch.stop();

            // Re-render
            setState(() {});
          }
        },

        // Checkbox-style icon showing if it's completed or not
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.item.completed
                ? Icon(
                    Icons.check_box,
                    color: const Color.fromARGB(255, 126, 121, 121),
                    size: checkboxSize,
                  )
                : Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.black,
                    size: checkboxSize,
                  ),
          ],
        ),

        title: Row(
          children: [
            // Todo item description
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: (() {
                  // On mobile
                  if (ResponsiveBreakpoints.of(context).isMobile) {
                    return Text(
                      widget.item.description,
                      style: TextStyle(
                        fontSize: 20,
                        decoration: widget.item.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontStyle: widget.item.completed
                            ? FontStyle.italic
                            : FontStyle.normal,
                        color: widget.item.completed
                            ? const Color.fromARGB(255, 126, 121, 121)
                            : Colors.black,
                      ),
                    );
                  }

                  // On tablet and up
                  else {
                    return Text(
                      widget.item.description,
                      style: TextStyle(
                        fontSize: 25,
                        decoration: widget.item.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontStyle: widget.item.completed
                            ? FontStyle.italic
                            : FontStyle.normal,
                        color: widget.item.completed
                            ? const Color.fromARGB(255, 126, 121, 121)
                            : Colors.black,
                      ),
                    );
                  }
                }()),
              ),
            ),

            // Stopwatch and timer button
            Column(
              children: [
                SizedBox(
                  child: (() {
                    // On mobile
                    if (ResponsiveBreakpoints.of(context).isMobile) {
                      return Text(
                        formatTime(_stopwatch.elapsedMilliseconds),
                        maxLines: 1,
                        style: const TextStyle(color: Colors.black54),
                      );
                    }

                    // On tablet and up
                    else {
                      return Text(
                        formatTime(_stopwatch.elapsedMilliseconds),
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 18,),
                      );
                    }
                  }()),
                ),

                // If the item is completed, we hide the button
                if (!widget.item.completed)
                  SizedBox(
                    child: (() {
                      // On mobile
                      if (ResponsiveBreakpoints.of(context).isMobile) {
                        return ElevatedButton(
                          key: itemCardTimerButtonKey,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _renderButtonBackground(),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: _handleButtonClick,
                          child: Text(
                            _renderButtonText(),
                            maxLines: 1,
                          ),
                        );
                      }

                      // On tablet and up
                      else {
                        return ElevatedButton(
                          key: itemCardTimerButtonKey,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _renderButtonBackground(),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: _handleButtonClick,
                          child: Text(
                            _renderButtonText(),
                            maxLines: 1,
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      }
                    }()),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
