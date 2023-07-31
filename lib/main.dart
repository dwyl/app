import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/breakpoints.dart';
import 'package:todo/stopwatch.dart';
import 'package:todo/item.dart';
import 'package:todo/utils.dart';

// Keys used for testing
final textfieldKey = UniqueKey();
final textfieldOnNewPageKey = UniqueKey();
final saveButtonKey = UniqueKey();
final itemCardWidgetKey = UniqueKey();
final itemCardTimerButtonKey = UniqueKey();
final backButtonKey = UniqueKey();
final logoKey = UniqueKey();

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
      child: const MaterialApp(home: HomePage()),
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
              List<Item> items = state.items;

              return SafeArea(
                child: Column(
                  children: [
                    ResponsiveLayout(
                      // On mobile
                      mobileBody: TextField(
                          key: textfieldKey,
                          controller: TextEditingController(),
                          keyboardType: TextInputType.none,
                          onTap: () {
                            Navigator.of(context).push(navigateToNewTodoItemPage());
                          },
                          maxLines: 2,
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.zero), hintText: 'Capture more things on your mind...'),
                          textAlignVertical: TextAlignVertical.top),

                      // On tablet and up
                      tabletBody: TextField(
                          key: textfieldKey,
                          controller: TextEditingController(),
                          keyboardType: TextInputType.none,
                          onTap: () {
                            Navigator.of(context).push(navigateToNewTodoItemPage());
                          },
                          maxLines: 2,
                          style: const TextStyle(fontSize: 30),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.zero), hintText: 'Capture more things on your mind...'),
                          textAlignVertical: TextAlignVertical.top),
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
        ));
  }
}

// PAGES ----------------------------

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
                    child: ResponsiveLayout(
                      // On mobile
                      mobileBody: TextField(
                        key: textfieldOnNewPageKey,
                        controller: txtFieldController,
                        expands: true,
                        maxLines: null,
                        autofocus: true,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.zero), hintText: 'start typing'),
                        textAlignVertical: TextAlignVertical.top,
                      ),

                      // On tablet and up
                      tabletBody: TextField(
                        key: textfieldOnNewPageKey,
                        controller: txtFieldController,
                        expands: true,
                        maxLines: null,
                        autofocus: true,
                        style: const TextStyle(fontSize: 30),
                        decoration: const InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.zero), hintText: 'start typing'),
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ),
                  ),

                  // Save button.
                  // When submitted, it adds a new todo item, clears the controller and navigates back
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      key: saveButtonKey,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 75, 192, 169),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      onPressed: () {
                        final value = txtFieldController.text;
                        if (value.isNotEmpty) {
                          // Create new item and create AddTodo event
                          Item newTodoItem = Item(description: value);
                          BlocProvider.of<TodoBloc>(context).add(AddTodoEvent(newTodoItem));

                          // Clear textfield
                          txtFieldController.clear();

                          // Go back to home page
                          Navigator.pop(context);
                        }
                      },
                      child: const ResponsiveLayout(
                          mobileBody: Text(
                            'Save',
                            style: TextStyle(fontSize: 24),
                          ),
                          tabletBody: Text(
                            'Save',
                            style: TextStyle(fontSize: 40),
                          )),
                    ),
                  ),
                ],
              ),
            )));
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

  const NavigationBar({super.key, required this.givenContext, this.showGoBackButton = false});

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
                Image.asset("assets/icon/icon.png", key: logoKey, fit: BoxFit.fitHeight, height: 30),
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
  late TimerEx _stopwatch;

  // Used to re-render the text showing the timer
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    _stopwatch = TimerEx(initialOffset: widget.item.getCumulativeDuration());

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

  // Start and stop timer button handler
  _handleButtonClick() {
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
  _renderButtonBackground() {
    if (_stopwatch.elapsedMilliseconds == 0) {
      return const Color.fromARGB(255, 75, 192, 169);
    } else {
      return _stopwatch.isRunning ? Colors.red : Colors.green;
    }
  }

  // Set button text according to status of stopwatch
  _renderButtonText() {
    if (_stopwatch.elapsedMilliseconds == 0) {
      return "Start";
    } else {
      return _stopwatch.isRunning ? "Stop" : "Resume";
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    double checkboxSize = deviceWidth > 425 ? 30 : 20;

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
                child: ResponsiveLayout(
                  // On mobile
                  mobileBody: Text(widget.item.description,
                      style: TextStyle(
                          fontSize: 20,
                          decoration: widget.item.completed ? TextDecoration.lineThrough : TextDecoration.none,
                          fontStyle: widget.item.completed ? FontStyle.italic : FontStyle.normal,
                          color: widget.item.completed ? const Color.fromARGB(255, 126, 121, 121) : Colors.black)),

                  // On tablet
                  tabletBody: Text(widget.item.description,
                      style: TextStyle(
                          fontSize: 25,
                          decoration: widget.item.completed ? TextDecoration.lineThrough : TextDecoration.none,
                          fontStyle: widget.item.completed ? FontStyle.italic : FontStyle.normal,
                          color: widget.item.completed ? const Color.fromARGB(255, 126, 121, 121) : Colors.black)),
                ),
              ),
            ),

            // Stopwatch and timer button
            Column(
              children: [
                ResponsiveLayout(
                  // On mobile
                  mobileBody: Text(formatTime(_stopwatch.elapsedMilliseconds), maxLines: 1, style: const TextStyle(color: Colors.black54)),

                  // On tablet
                  tabletBody:
                      Text(formatTime(_stopwatch.elapsedMilliseconds), maxLines: 1, style: const TextStyle(color: Colors.black54, fontSize: 18)),
                ),

                // If the item is completed, we hide the button
                if (!widget.item.completed)
                  ResponsiveLayout(

                      // On mobile
                      mobileBody: ElevatedButton(
                        key: itemCardTimerButtonKey,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _renderButtonBackground(),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                        onPressed: _handleButtonClick,
                        child: Text(
                          _renderButtonText(),
                          maxLines: 1,
                        ),
                      ),

                      // On tablet
                      tabletBody: ElevatedButton(
                        key: itemCardTimerButtonKey,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _renderButtonBackground(),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                        onPressed: _handleButtonClick,
                        child: Text(
                          _renderButtonText(),
                          maxLines: 1,
                          style: const TextStyle(fontSize: 20),
                        ),
                      )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
