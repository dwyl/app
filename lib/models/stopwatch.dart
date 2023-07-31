/// Stopwatch wrapper that allows stopwatch to be restarted.
/// Check https://github.com/dwyl/flutter-stopwatch-tutorial#persisting-between-sessions-and-extending-stopwatch-capabilities.
class TimerEx {
  final Stopwatch _stopWatch = Stopwatch();

  final Duration _initialOffset;

  TimerEx({Duration initialOffset = Duration.zero})
      : _initialOffset = initialOffset;

  start() => _stopWatch.start();

  stop() => _stopWatch.stop();

  bool get isRunning => _stopWatch.isRunning;

  int get elapsedMilliseconds =>
      _stopWatch.elapsedMilliseconds + _initialOffset.inMilliseconds;
}
