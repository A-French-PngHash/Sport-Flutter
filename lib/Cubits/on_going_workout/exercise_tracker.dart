import 'dart:ffi';

import 'package:sport/Data/Model/exercise/exercise.dart';
import 'package:sport/Data/Model/workout/workout.dart';
import 'package:sport/Data/exercise_repository.dart';

/// Keeps track of the current exercise.
class ExerciseTracker {
  late final Iterable<String> _exercisesName;
  int _exerciseIndex = 0;
  ExerciseRepository _exerciseRepository;
  Workout _workout;

  late Exercise current;

  /// Load current exercise asynchronously.
  Future<void> _loadCurrent() async {
    final exList = await this._exerciseRepository.exerciseList(_workout);
    current = exList[_exercisesName.elementAt(_exerciseIndex)]!;
  }

  /// Private factory. Initialize code goes here.
  ExerciseTracker._create(this._exerciseRepository, this._workout) {
    // The exercise order get shuffled everytime a new workout is started.
    final _exercisesOrder = _workout.exercises..shuffle();
    _exercisesName = _exercisesOrder.map((e) => e["name"]);
  }

  /// Public factory
  static Future<ExerciseTracker> create(_exerciseRepository, _workout) async {
    var component = ExerciseTracker._create(_exerciseRepository, _workout);
    await component._loadCurrent();
    return component;
  }

  /// Wether the current exercise is the last.
  bool get isLast {
    return (_exerciseIndex >= _exercisesName.length - 1);
  }

  /// Go to the next exercise.
  Future<Void?> next() async {
    if (!isLast) {
      // Can go to the next one.
      _exerciseIndex += 1;
      await _loadCurrent();
    }
  }
}
