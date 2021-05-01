import 'package:sport/Data/Model/workout/workout.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class WorkoutRepository {
  /// Fetch the list of workouts.
  Future<List<Workout>> fetchWorkoutList() async {
    final workoutString = await rootBundle.loadString("assets/workouts.json");
    final workoutJson = await json.decode(workoutString);
    print(workoutJson["workouts"]);
    List<Workout> workoutList = [];
    for (final element in workoutJson["workouts"] as List) {
      workoutList.add(Workout.fromJson(element));
    }

    return workoutList;
  }
}
