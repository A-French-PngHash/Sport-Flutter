import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sport/AudioPlayers/audio_player.dart';
import 'package:sport/Cubits/on_going_workout/image_service.dart';
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
  ImageService _imageService = ImageService();

  /// Beginning of the current set. Unix timestamp.
  int? currentSetStartedAt;

  /// Beginning of the current rest time. Unix timestamp.
  int? currentRestStartedAt;

  /// Current rep count. Correspond to the rep number being done by the user.
  int? currentRepCount;

  /// Current timer for the exercise's set.
  /// The timer can either be one that's counting each reps (on a predefined
  /// rep length). Or it can be a timer that's counting the seconds that passed
  /// since the beginning (fixed time exercises).
  ///
  /// In both cases, this timer needs to be stopped whenever the exercise
  /// finishes (which can be triggered automatically eg. reached the end of the
  /// time, or by the user, eg. the user pressed the 'next exercise button') so
  /// we need to keep a reference to it.
  Timer? exerciseSetTimer;

  Exercise get current {
    return exerciseTracker.current;
  }

  /// Number of seconds left for the current set.
  ///
  /// The exercise must be of type length and currentSetStartedAt must not be null.
  int? get secondsLeft {
    if (currentSetStartedAt != null && current.length != null) {
      return (current.length! - ((DateTime.now().millisecondsSinceEpoch - currentSetStartedAt!) / 1000)).floor();
    } else if (current.reps == null) {
      // The exercise is of type length but the currentRestStartedAt hasnt been set. In this case, the user is at the begining of the exercise.
      return current.length;
    }
  }

  /// Number of seconds left for the current rest.
  int? get restSecondLeft {
    if (currentRestStartedAt != null) {
      return (_workout.restTime - ((DateTime.now().millisecondsSinceEpoch - currentRestStartedAt!) / 1000)).ceil();
    }
  }

  /// Current set done by the user.
  int currentSetCount = 1;

  OnGoingWorkoutCubit(this._workout, ExerciseRepository exerciseRepository) : super(OnGoingWorkoutState.initial()) {
    this.audioPlayer = SportAudioPlayer();
    _loadExerciseTracker(exerciseRepository).then((value) => _startWorkout());
  }

  /// Load the exercise tracker. Once it is loaded, the workout can begin.
  Future _loadExerciseTracker(
    ExerciseRepository exerciseRepository,
  ) async {
    this.exerciseTracker = await ExerciseTracker.create(exerciseRepository, _workout);
  }

  /// Called when the current exercise ended.
  ///
  /// We need to start the rest period here.
  finishedExercise() async {
    if (exerciseTracker.isLast) {
      audioPlayer.anounceEndOfWorkout();
      return;
    }
    await audioPlayer.anounceEndOfExercise(current, _workout.restTime);

    currentRestStartedAt = DateTime.now().millisecondsSinceEpoch;

    // Emiting rest state.
    emit(OnGoingWorkoutState.Rest(_workout.restTime));

    // Rest timer.
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (restSecondLeft! <= 0) {
        // Rest ended.
        exerciseTracker.next().then((value) {
          startExerciseForCurrent();
          timer.cancel();
        });
      }
      emit(OnGoingWorkoutState.Rest(restSecondLeft!));
    });
  }

  /// Start the exercise set as "current". This is called when the exercise just
  /// got set as current and needs to be started.
  startExerciseForCurrent() async {
    if (current.reps == null && current.length == null) {
      throw "Unknown exercise type. Both length and reps parameters are null for object ${exerciseTracker.current}";
    }
    emitCurrent();
    await audioPlayer.announceExercise(current);
    currentSetCount = 1;
    startSetForCurrentExercise();
  }

  /// Called when the current set ended. The function then does different things
  /// depending on the current state.
  finishedSet() {
    if (exerciseSetTimer != null) {
      exerciseSetTimer!.cancel();
      exerciseSetTimer = null;
    }
    // Increasing the set count.
    currentSetCount += 1;
    if (current.sets < currentSetCount) {
      // All sets are finished. Switching to next exercise.
      finishedExercise();
    } else {
      startSetForCurrentExercise();
    }
  }

  /// Start the set.
  startSetForCurrentExercise() async {
    final name = current.name;
    final sets = current.sets;
    final reps = current.reps;
    final length = current.length;

    // Emit the initial state.
    emitCurrent();
    // Announce set.
    if (currentSetCount != 1) {
      // Not anouncing if the first set.
      await audioPlayer.anounceNextSet(current, currentSetCount);
    }

    currentSetStartedAt = DateTime.now().millisecondsSinceEpoch;
    _imageService.startFor(current, (imageUrl) {
      emitCurrent(imageUrl: imageUrl);
    });
    if (length != null) {
      // Length type exercise.
      exerciseSetTimer = Timer.periodic(Duration(milliseconds: 100), (_) {
        if (secondsLeft! <= 0) {
          // The set ends now.
          finishedSet();
        }
        emitCurrent();
      });
    } else {
      if (current.repetitionLength != null) {
        // The app needs to say each rep.
        exerciseSetTimer = Timer.periodic(Duration(milliseconds: (current.repetitionLength! * 1000).floor()), (_) {
          audioPlayer.anounceNumber(currentRepCount!);
          if (currentRepCount! >= current.reps!) {
            // The set ends now.
            finishedSet();
          }
          currentRepCount = currentRepCount! + 1;
        });
      }
    }
  }

  /// Start the workout.
  ///
  /// Emit the first states and starts the required timers.
  _startWorkout() async {
    startExerciseForCurrent();
  }

  /// Next button pressed; the user wants to jump to the next exercise.
  ///
  /// There is two case scenario here, if the exercise was of type rep and the
  /// user was counting the reps himself then this function will jump to the rest time.
  /// Otherwise, it jumps directly to the start of the next exercise.
  /// If the user is currently in a rest time then jumps to the start of the
  /// next exercise.
  nextButtonPressed() {
    if (exerciseSetTimer != null) {
      exerciseSetTimer!.cancel();
      exerciseSetTimer = null;
    }

    //TODO: - Check if user is in a rest time

    if (current.reps != null && current.repetitionLength == null) {
      // Starts rest time.
      audioPlayer.stop();
      finishedExercise();
    } else {
      // Jumps to next exercise.
    }
  }

  previousButtonPressed() {}

  /// Emit the current exercise state.
  ///
  /// - imageUrl : Url of the image to display. Optional, if not provided then
  /// fetches the image url from the imageService by asking for the first image.
  emitCurrent({String? imageUrl}) {
    String? image = imageUrl;
    if (image == null) {
      // No image provided. Will get the first exercise for the current exercise.
      image = _imageService.firstImageFor(current);
    }
    emit(OnGoingWorkoutState.ExerciseInProgress(image, currentSetCount, current.sets,
        repCount: current.reps, secondsLeft: secondsLeft));
  }
}
