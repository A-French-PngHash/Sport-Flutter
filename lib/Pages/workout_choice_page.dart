import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/Cubits/workout_choice/cubit/workout_choice_cubit.dart';
import 'package:sport/Pages/workout_row.dart';

class WorkoutChoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocBuilder<WorkoutChoiceCubit, WorkoutChoiceState>(
            builder: (context, state) {
          return state.maybeWhen((names) {
            // Workout's names.
            return buildListWithNames(names);
          }, orElse: () => Text("Loading..."));
        }),
      ),
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
