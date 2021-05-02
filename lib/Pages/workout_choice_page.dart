import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/Cubits/workout_choice/cubit/workout_choice_cubit.dart';
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
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return Text("Workout chosen");
                }));
              }
            }, orElse: () {});
          },
        ),
      ]),
    );
  }

  Widget buildListWithNames(List names) {
    return ListView(
      children: [
        ...names.map((e) {
          return WorkoutRow(e);
        })
      ],
    );
  }
}
