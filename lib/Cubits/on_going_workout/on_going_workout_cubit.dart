import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sport/AudioPlayers/audio_player.dart';
import 'package:sport/Data/Model/exercise/exercise.dart';
import 'package:sport/Data/Model/workout/workout.dart';
import 'package:sport/Data/exercise_repository.dart';

import 'exercise_tracker.dart';

part 'on_going_workout_state.dart';
part 'on_going_workout_cubit.freezed.dart';

class OnGoingWorkoutCubit extends Cubit<OnGoingWorkoutState> {
  Workout _workout;
  late ExerciseTracker exerciseTracker;
  late SportAudioPlayer audioPlayer;

  Exercise get current {
    return exerciseTracker.current;
  }

  OnGoingWorkoutCubit(this._workout, ExerciseRepository exerciseRepository) : super(OnGoingWorkoutState.initial()) {
    this.audioPlayer = SportAudioPlayer();
    _loadExerciseTracker(exerciseRepository).then((value) => startWorkout());
  }

  /// Load the exercise tracker. Once it is loaded, the workout can begin.
  Future _loadExerciseTracker(
    ExerciseRepository exerciseRepository,
  ) async {
    this.exerciseTracker = await ExerciseTracker.create(exerciseRepository, _workout);
  }

  /// Start the workout.
  ///
  /// Emit the first states and starts the required timers.
  startWorkout() async {
    final name = current.name;
    final sets = current.sets;
    final reps = current.reps;
    final length = current.length;

    if (reps == null && length == null) {
      throw "Unknown exercise type. Both length and reps parameters are null for object ${exerciseTracker.current}";
    }
    emit(OnGoingWorkoutState.ExerciseInProgress(name, sets, repCount: reps, secondsLeft: length));

    // Announcing the exercise
    await audioPlayer.announceExercise(current, () => {print("Finished anounchment.")});
  }
}
