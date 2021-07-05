import 'dart:ffi';

import 'package:sport/Data/Model/exercise/exercise.dart';
import 'package:sport/Data/exercise_repository.dart';

/// Keeps track of the current exercise.
class ExerciseTracker {
  int _exerciseIndex = 0;
  ExerciseRepository _exerciseRepository;

  late Exercise current;

  /// List for the exercises. In the final order.
  late List<Exercise> _exList;

  /// Load current exercise asynchronously.
  Future<void> _loadCurrent() async {
    current = _exList[_exerciseIndex];
  }

  /// Private factory. Initialize code goes here.
  ExerciseTracker._create(this._exerciseRepository);

  /// Public factory
  static Future<ExerciseTracker> create(_exerciseRepository, _workout) async {
    var component = ExerciseTracker._create(_exerciseRepository);
    // Exercises gets shuffled here :
    component._exList = (await component._exerciseRepository.exerciseList(_workout))..shuffle();
    await component._loadCurrent();
    return component;
  }

  /// Whether the current exercise is the last.
  bool get isLast {
    return (_exerciseIndex >= _exList.length - 1);
  }

  /// Whethere the current exercise is the first.
  bool get isFirst {
    return _exerciseIndex == 0;
  }

  /// Go to the next exercise.
  Future<Void?> next() async {
    if (!isLast) {
      // Can go to the next one.
      _exerciseIndex += 1;
      await _loadCurrent();
    }
  }

  Future previous() async {
    if (!isFirst) {
      // Can go to the previous one.
      _exerciseIndex -= 1;
      await _loadCurrent();
    }
  }
}
