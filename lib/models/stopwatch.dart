/// Stopwatch wrapper that allows stopwatch to be restarted.
/// Check https://github.com/dwyl/flutter-stopwatch-tutorial#persisting-between-sessions-and-extending-stopwatch-capabilities.
class TimerStopwatch extends Stopwatch {
  final Stopwatch _stopWatch = Stopwatch();

  final Duration _initialOffset;

  TimerStopwatch({Duration initialOffset = Duration.zero})
      : _initialOffset = initialOffset;

  @override
  void start() => _stopWatch.start();

  @override
  void stop() => _stopWatch.stop();

  @override
  bool get isRunning => _stopWatch.isRunning;

  @override
  int get elapsedMilliseconds =>
      _stopWatch.elapsedMilliseconds + _initialOffset.inMilliseconds;
}
