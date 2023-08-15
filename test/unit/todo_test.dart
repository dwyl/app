import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:dwyl_app/models/item.dart';

void main() {
  test('Cumulative duration after starting and stopping timer should be more than 0', () {
    const description = 'description';

    final item = Item(description: description);

    // Checking attributes
    expect(item.description, description);

    // Start and stop timer
    item.startTimer();
    sleep(const Duration(milliseconds: 500));
    item.stopTimer();

    // Start and stop timer another time
    item.startTimer();
    sleep(const Duration(milliseconds: 500));
    item.stopTimer();

    // Some time must have passed
    expect(item.getCumulativeDuration(), isNot(equals(0)));
  });

  test('Start timer multiple times and stopping timer will not error out', () {
    const description = 'description';

    final item = Item(description: description);

    // Checking attributes
    expect(item.description, description);

    // Start timers three times
    item.startTimer();
    item.startTimer();
    item.startTimer();

    // Stop timer after half a second
    sleep(const Duration(milliseconds: 500));
    item.stopTimer();

    // Some time must have passed
    expect(item.getCumulativeDuration(), isNot(equals(0)));
  });
}
