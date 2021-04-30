import 'package:sport/Data/Model/workout/workout.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class WorkoutRepository {
  /// Fetch the list of workouts.
  Future<List<Workout>> fetchWorkoutList() async {
    final workoutString = await rootBundle.loadString("exercises.json");
    final workoutJson = json.decode(workoutString);
    return workoutJson;
  }
}
