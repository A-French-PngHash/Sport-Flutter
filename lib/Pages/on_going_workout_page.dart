import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/Cubits/on_going_workout/on_going_workout_cubit.dart';
import 'package:sport/Pages/exercise_navigation.dart';

class OnGoingWorkoutPage extends StatelessWidget {
  /// Name used to display a title.
  final String _workoutName;

  OnGoingWorkoutPage(this._workoutName) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$_workoutName"),
      ),
      body: BlocBuilder<OnGoingWorkoutCubit, OnGoingWorkoutState>(
        builder: (context, state) {
          return state.when(
            initial: () {
              return Text("Loading...");
            },
            Rest: buildRest,
            ExerciseInProgress: buildExerciseInProgress,
          );
        },
      ),
    );
  }

  Widget buildExerciseInProgress(String imageUrl, int setCount, int currentSet, int? repCount, int? secondsRemaining) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          secondsRemaining != null ? secondsRemaining.toString() : repCount.toString(),
          style: TextStyle(fontSize: 30),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Text("$setCount/$currentSet")],
        ),
        Flexible(child: Image.asset(imageUrl)),
        ExerciseNavigation(),
      ],
    );
  }

  Widget buildRest(int secondLeft) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Text(
          formatTime(secondLeft),
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 40),
        ),
        Spacer(),
        ExerciseNavigation(),
      ],
    );
  }

  /// Format the time into minutes and seconds.
  ///
  /// Takes a number of seconds and return a string that's a human readable way
  /// of displaying the time.
  String formatTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final sec = seconds - (minutes * 60);
    return "${minutes < 10 ? "0" : ""}$minutes:${sec < 10 ? "0" : ""}$sec";
  }
}
