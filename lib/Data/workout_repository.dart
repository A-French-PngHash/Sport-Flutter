import 'dart:async';

import 'package:sport/Data/Model/workout/workout.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class WorkoutRepository {
  List<Workout>? _workoutList;
  List<String>? _workoutNameList;

  Future<List<Workout>> get workoutList async {
    if (_workoutList != null) {
      return Future<List<Workout>>.value(_workoutList);
    } else {
      final workoutString = await rootBundle.loadString("assets/workouts.json");
      final workoutJson = await json.decode(workoutString);
      List<Workout> workoutList = [];
      for (final element in workoutJson["workouts"] as List) {
        workoutList.add(Workout.fromJson(element));
      }
      _workoutList = workoutList;
      return workoutList;
    }
  }

  Future<List<String>> get workoutNameList async {
    if (_workoutNameList != null) {
      return Future<List<String>>.value(_workoutNameList);
    } else {
      final workouts = await workoutList;
      List<String> names = [];
      for (final workout in workouts) {
        names.add(workout.name);
      }
      _workoutNameList = names;
      return names;
    }
  }

  Future<Workout> workoutFromName(String name) async {
    final workouts = await workoutList;
    for (final workout in workouts) {
      if (workout.name == name) {
        return workout;
      }
    }
    throw ("No workouts by that name.");
  }
}
