import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/Cubits/workout_choice/cubit/workout_choice_cubit.dart';
import 'package:sport/Data/workout_repository.dart';
import 'package:sport/Pages/workout_choice_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sport',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: BlocProvider(
        create: (context) => WorkoutChoiceCubit(WorkoutRepository()),
        child: WorkoutChoicePage(),
      ),
    );
  }
}
