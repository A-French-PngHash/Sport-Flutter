import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/Cubits/workout_choice/workout_choice_cubit.dart';

/// Row for a workout. Used in the list view where the user picks a workout.
class WorkoutRow extends StatelessWidget {
  final String name;

  WorkoutRow(this.name) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
            onPressed: () {
              final workoutChoiceCubit = context.read<WorkoutChoiceCubit>();
              workoutChoiceCubit.selectedWorkout(name);
            },
            child: Text(this.name)),
      ),
    );
  }
}
