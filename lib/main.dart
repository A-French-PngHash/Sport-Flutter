import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/Data/workout_repository.dart';
import 'package:sport/Pages/workout_choice_page.dart';
import 'package:sport/Theme/theme.dart';
import 'package:flutter/services.dart';

import 'Cubits/workout_choice/workout_choice_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      themeMode: ThemeMode.light,
      title: 'Sport',
      theme: Themes().theme1,
      home: BlocProvider(
        create: (context) => WorkoutChoiceCubit(WorkoutRepository()),
        child: WorkoutChoicePage(),
      ),
    );
  }
}
