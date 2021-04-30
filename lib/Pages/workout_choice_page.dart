import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/Cubits/workout_choice/cubit/workout_choice_cubit.dart';

class WorkoutChoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<WorkoutChoiceCubit, WorkoutChoiceState>(
          builder: (context, state) {
        return state.maybeWhen((names) {
          return Text("t");
        }, orElse: () => Text("t"));
      }),
    );
  }

  Widget orElse() {}
}
