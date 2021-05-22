import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sport/Data/Model/workout/workout.dart';
import 'package:sport/Data/exercise_repository.dart';

import 'exercise_tracker.dart';

part 'on_going_workout_state.dart';
part 'on_going_workout_cubit.freezed.dart';

class OnGoingWorkoutCubit extends Cubit<OnGoingWorkoutState> {
  Workout _workout;
  late ExerciseTracker exerciseTracker;

  OnGoingWorkoutCubit(this._workout, ExerciseRepository exerciseRepository) : super(OnGoingWorkoutState.initial()) {
    _loadExerciseTracker(exerciseRepository);
  }

  /// Load the exercise tracker. Once it is loaded, the workout can begin.
  void _loadExerciseTracker(
    ExerciseRepository exerciseRepository,
  ) async {
    this.exerciseTracker = await ExerciseTracker.create(exerciseRepository, _workout);
    emit(OnGoingWorkoutState.ExerciseInProgress(
      exerciseTracker.current.name,
      exerciseTracker.current.sets,
      repCount: exerciseTracker.current.reps,
      secondsLeft: 0,
    ));
  }
}
