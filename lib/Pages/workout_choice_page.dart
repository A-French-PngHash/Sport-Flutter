import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/Cubits/on_going_workout/on_going_workout_cubit.dart';
import 'package:sport/Cubits/workout_choice/workout_choice_cubit.dart';
import 'package:sport/Data/Model/workout/workout.dart';
import 'package:sport/Data/exercise_repository.dart';
import 'package:sport/Pages/on_going_workout_page.dart';
import 'package:sport/Pages/workout_row.dart';

class WorkoutChoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Pick a workout",
          style: TextStyle(fontSize: 40),
        ),
        BlocConsumer<WorkoutChoiceCubit, WorkoutChoiceState>(
          builder: (context, state) {
            return state.maybeWhen((names, workout) {
              // Workout's row.
              return buildListWithNames(names);
            }, orElse: () => Text("Loading..."));
          },
          listener: (context, state) {
            state.maybeWhen((_, workoutChosen) {
              if (workoutChosen != null) {
                // Pushing new view here.
                pushOnGoingWorkoutView(context, workoutChosen);
              }
            }, orElse: () {});
          },
        ),
      ]),
    );
  }

  void pushOnGoingWorkoutView(BuildContext context, Workout workoutChosen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return BlocProvider(
        create: (context) => OnGoingWorkoutCubit(workoutChosen, ExerciseRepository()),
        child: OnGoingWorkoutPage(workoutChosen.name, workoutChosen.exercises.length),
      );
    }));
  }

  Widget buildListWithNames(List names) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        ...names.map((e) {
          return WorkoutRow(e);
        })
      ],
    );
  }
}
