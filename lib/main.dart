import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/Data/Model/workout/workout.dart';
import 'package:sport/Data/workout_repository.dart';
import 'package:sport/Pages/workout_choice_page.dart';

import 'Cubits/workout_choice/workout_choice_cubit.dart';
import 'Data/exercise_repository.dart';
import 'Pages/on_going_workout_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      title: 'Sport',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      home: BlocProvider(
        create: (context) => WorkoutChoiceCubit(WorkoutRepository()),
        child: WorkoutChoicePage(),
      ),
    );
  }
}
