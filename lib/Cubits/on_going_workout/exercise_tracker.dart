import 'dart:ffi';

import 'package:sport/Data/Model/exercise/exercise.dart';
import 'package:sport/Data/Model/workout/workout.dart';
import 'package:sport/Data/exercise_repository.dart';

/// Keeps track of the current exercise.
class ExerciseTracker {
  int _exerciseIndex = 0;
  ExerciseRepository _exerciseRepository;
  Workout _workout;

  late Exercise current;

  /// List for the exercises. In the final order.
  late List<Exercise> _exList;

  /// Load current exercise asynchronously.
  Future<void> _loadCurrent() async {
    current = _exList[_exerciseIndex];
  }

  /// Private factory. Initialize code goes here.
  ExerciseTracker._create(this._exerciseRepository, this._workout);

  /// Public factory
  static Future<ExerciseTracker> create(_exerciseRepository, _workout) async {
    var component = ExerciseTracker._create(_exerciseRepository, _workout);
    // Exercises gets shuffled here :
    component._exList = (await component._exerciseRepository.exerciseList(_workout))..shuffle();
    component._exList.insert(0, Exercise("Zottman Curl", 4, 3, length: 20));
    await component._loadCurrent();
    return component;
  }

  /// Wether the current exercise is the last.
  bool get isLast {
    return (_exerciseIndex >= _exList.length - 1);
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
