import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/Cubits/on_going_workout/on_going_workout_cubit.dart';
import 'package:sport/Pages/Utility/progress_bar.dart';
import 'package:sport/Pages/exercise_navigation.dart';

class OnGoingWorkoutPage extends StatelessWidget {
  /// Name used to display a title.
  final String _workoutName;

  /// Exercise count for this workout.
  final int _exerciseCount;

  late final double screenWidth;

  OnGoingWorkoutPage(this._workoutName, this._exerciseCount) {}

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("$_workoutName"),
        leading: BackButton(
          onPressed: () {
            final cubit = context.read<OnGoingWorkoutCubit>();
            cubit.backButtonPressed();
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<OnGoingWorkoutCubit, OnGoingWorkoutState>(
        builder: (context, state) {
          return state.when(
            initial: () {
              return Text("Loading...");
            },
            Rest: buildRest,
            ExerciseInProgress: buildExerciseInProgress,
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget buildExerciseInProgress(int currentExerciseIndex, String imageUrl, String exerciseName, int setCount,
      int currentSet, bool paused, int? repCount, int? secondsRemaining) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SegmentedProgressBar(_exerciseCount, currentExerciseIndex, screenWidth - 40),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Text("$setCount/$currentSet")],
        ),
        Flexible(
          child: Image.asset(
            imageUrl,
            gaplessPlayback: true,
          ),
        ),
        Text(
          exerciseName.toUpperCase(),
          style: TextStyle(fontSize: 20),
        ),
        Text(
          secondsRemaining != null ? formatTime(secondsRemaining) : repCount.toString(),
          style: TextStyle(fontSize: 30, color: Colors.green),
        ),
        ExerciseNavigation(paused),
      ],
    );
  }

  Widget buildRest(int secondLeft, int currentExerciseIndex, bool paused) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SegmentedProgressBar(_exerciseCount, currentExerciseIndex, screenWidth - 40),
        ),
        Spacer(),
        Text(
          formatTime(secondLeft),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        Spacer(),
        ExerciseNavigation(paused),
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
