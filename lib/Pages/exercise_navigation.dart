import 'package:flutter/material.dart';
import 'package:sport/Cubits/on_going_workout/on_going_workout_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Responsible for the displaying of the arrows. Those widgets allow the manual
/// navigation from the user in the different exercise.
class ExerciseNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrainst) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
            child: Icon(
              Icons.arrow_left_rounded,
              size: constrainst.biggest.width / 4,
              color: Colors.white,
            ),
            onPressed: () {
              previousButtonPressed(context);
            },
          ),
          TextButton(
            onPressed: () {},
            child: Icon(Icons.pause_circle, size: constrainst.biggest.width / 4, color: Color(0xFF198C45),),
          ),
          TextButton(
            child: Icon(Icons.arrow_right_rounded, size: constrainst.biggest.width / 4, color: Colors.white),
            onPressed: () {
              nextButtonPressed(context);
            },
          ),
        ]);
      },
    );
  }

  nextButtonPressed(BuildContext context) {
    final cubit = context.read<OnGoingWorkoutCubit>();
    cubit.nextButtonPressed();
  }

  previousButtonPressed(BuildContext context) {
    final cubit = context.read<OnGoingWorkoutCubit>();
    cubit.previousButtonPressed();
  }

  pauseButtonPressed(BuildContext context) {
    //TODO: - Pause workout.
  }
}
