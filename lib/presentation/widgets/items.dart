import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';

const itemCardWidgetKey = Key('itemCardWidgetKey');
const itemCardTimerButtonKey = Key('itemCardTimerButtonKey');

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
                          color: Colors.black54,
                          fontSize: 18,
                        ),
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
