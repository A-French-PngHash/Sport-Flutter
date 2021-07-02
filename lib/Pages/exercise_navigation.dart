import 'package:flutter/material.dart';
import 'package:sport/Cubits/on_going_workout/on_going_workout_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Responsible for the displaying of the arrows. Those widgets allow the manual
/// navigation from the user in the different exercise.
class ExerciseNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextButton(
          child: Icon(Icons.arrow_left_rounded, size: 100),
          onPressed: () {
            previousButtonPressed(context);
          }),
      TextButton(
        child: Icon(Icons.arrow_right_rounded, size: 100),
        onPressed: () {
          nextButtonPressed(context);
        },
      ),
    ]);
  }

  nextButtonPressed(BuildContext context) {
    print("next");
    final cubit = context.read<OnGoingWorkoutCubit>();
    cubit.nextButtonPressed();
  }

  previousButtonPressed(BuildContext context) {
    final cubit = context.read<OnGoingWorkoutCubit>();
    cubit.previousButtonPressed();
  }
}
