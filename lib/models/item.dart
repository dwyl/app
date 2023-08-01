import 'package:uuid/uuid.dart';

// Uuid to generate Ids for the todos
Uuid uuid = const Uuid();

/// Todo class.
/// Each `Todo` has an `id`, `description` and `completed` boolean field.
class Item {
  final String id = uuid.v4();
  final String description;
  final bool completed;
  final List<ItemTimer> _timersList = [];

  Item({
    required this.description,
    this.completed = false,
  });

  // Adds a new timer that starts on current time
  startTimer() {
    if (_timersList.isEmpty) {
      _timersList.add(ItemTimer(null, start: DateTime.now()));
    } else {
      var lastTimer = _timersList.last;

      // Only create a new timer if the last one is finished
      if (lastTimer.end != null) {
        _timersList.add(ItemTimer(null, start: DateTime.now()));
      }
    }
  }

  // Stop the timer that is at the end of the list
  stopTimer() {
    if (_timersList.isNotEmpty) {
      var lastTimer = _timersList.last;

      // Only stop last timer if the end is null
      if (lastTimer.end == null) {
        lastTimer.end = DateTime.now();
        _timersList[_timersList.length - 1] = lastTimer;
      }
    }
  }

  Duration getCumulativeDuration() {
    if (_timersList.isEmpty) return Duration.zero;

    // Accumulate the duration of every timer
    var accumulativeDuration = const Duration();
    for (var timer in _timersList) {
      final stop = timer.end;
      if (stop != null) {
        accumulativeDuration += stop.difference(timer.start);
      }
    }

    return accumulativeDuration;
  }
}

/// Timer class
class ItemTimer {
  final DateTime start;
  DateTime? end;

  ItemTimer(this.end, {required this.start});
}
