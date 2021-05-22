import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sport/Data/Model/exercise/exercise.dart';

import 'Model/workout/workout.dart';

class ExerciseRepository {
  Map<String, Exercise>? _exercises;

  Future<Map<String, Exercise>> exerciseList(Workout workout) async {
    if (_exercises != null) {
      // Exercises are already loaded.
      return Future<Map<String, Exercise>>.value(_exercises);
    } else {
      // Exercises need to be loaded.

      _exercises = new Map();
      // List of every exercise including the one not present in the workout.
      final fullExerciseList = await json.decode(await rootBundle.loadString("assets/exercises.json"));

      // The exercise data from a list inside the workout object. This only
      // contains the exercises present in the workout.
      final workoutExerciseJson = workout.exercises;
      for (final element in workoutExerciseJson) {
        // Some date from exercises is constant. Here the programm loads it.
        // The other data comes directly from a list inside the workout object.
        final exo = fullExerciseList[element["name"]];
        if (exo == null) {
          throw "Exercise does not have the same name in exercises.json. The exercise name is ${element['name']}";
        }
        element["imagesCount"] = exo["imagesCount"] as int;
        element["repetitionLength"] = exo["repetitionLength"] as double?;

        Exercise exercise = Exercise.fromJson(element);
        _exercises![exercise.name] = exercise;
      }
      return Future<Map<String, Exercise>>.value(_exercises);
    }
  }
}
