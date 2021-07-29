import 'package:pausable_timer/pausable_timer.dart';

class PeriodicPausableTimer implements PausableTimer {
  late final PausableTimer timer;

  /// Constructor for [PeriodicPausableTimer]
  /// - isPaused : Whether the workout is paused at the time of the timer's
  /// creation.
  PeriodicPausableTimer(Duration duration, void Function() callback, bool isPaused) {
    timer = PausableTimer(
      duration,
      () {
        callback();
        timer
          ..reset()
          ..start();
      },
    );
    timer.start();
    
    if (isPaused) {
      // This is a special case. If the user paused while an announcment 
      // period, the timer was not yet started. It is however starting now 
      // that the announcment ended. 
      timer.pause();
    }
  }

  @override
  void cancel() {
    timer.cancel();
  }

  @override
  Duration get duration => timer.duration;

  @override
  Duration get elapsed => timer.elapsed;

  @override
  bool get isActive => timer.isActive;

  @override
  bool get isCancelled => timer.isCancelled;

  @override
  bool get isExpired => timer.isExpired;

  @override
  bool get isPaused => timer.isPaused;

  @override
  void pause() {
    timer.pause();
  }

  @override
  void reset() {
    timer.reset();
  }

  @override
  void start() {
    timer.start();
  }

  @override
  int get tick => timer.tick;
}
