import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../Services/audio_player.dart';
import '../Services/image_service.dart';
import 'package:sport/Data/Model/exercise/exercise.dart';
import 'package:sport/Data/Model/workout/workout.dart';
import 'package:sport/Data/exercise_repository.dart';
import '../Utility/periodic_pausable_timer.dart';

import '../Services/exercise_tracker.dart';

part 'on_going_workout_state.dart';
part 'on_going_workout_cubit.freezed.dart';

class OnGoingWorkoutCubit extends Cubit<OnGoingWorkoutState> {
  Workout _workout;
  late ExerciseTracker exerciseTracker;
  late SportAudioPlayer audioPlayer;
  late ImageService _imageService;

  /// Beginning of the current set. Unix timestamp in milliseconds.
  int? currentSetStartedAt;

  /// Beginning of the current rest time. Unix timestamp in milliseconds.
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
  PeriodicPausableTimer? exerciseSetTimer;

  PeriodicPausableTimer? restTimer;

  /// Whether the rest time has begun. This includes the anouncment time of the
  /// rest.
  bool restBegan = false;

  /// Whether the workout is paused.
  bool isPaused = false;

  /// When the current pause started. Unix timestamp in miliseconds.
  int? pauseStartedAt;

  Exercise get current {
    return exerciseTracker.current;
  }

  /// Number of seconds left for the current set.
  ///
  /// The exercise must be of type length and currentSetStartedAt must not be null.
  int? get secondsLeft {
    if (currentSetStartedAt != null && current.length != null) {
      return (current.length! - ((DateTime.now().millisecondsSinceEpoch - currentSetStartedAt!) / 1000)).ceil();
    } else if (current.reps == null) {
      // The exercise is of type length but the currentSetStartedAt hasnt been set. In this case, the user is at the begining of the exercise.
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
    _loadServices(exerciseRepository).then((value) => {_startWorkout()});
  }

  /// Load services used by this cubit. These includes ImageService,
  /// ExerciseTracker and SportAudioPlayer.
  Future<void> _loadServices(
    ExerciseRepository exerciseRepository,
  ) async {
    this.audioPlayer = SportAudioPlayer();
    await _loadImageService();
    await _loadExerciseTracker(exerciseRepository);
  }

  Future<void> _loadImageService() async {
    this._imageService = await ImageService.create();
  }

  Future<void> _loadExerciseTracker(
    ExerciseRepository exerciseRepository,
  ) async {
    this.exerciseTracker = await ExerciseTracker.create(exerciseRepository, _workout);
  }

  /// Called when the current exercise ended.
  ///
  /// Rest period initiated here.
  Future<void> finishedExercise() async {
    currentSetCount = 1;
    _imageService.stop();
    if (exerciseTracker.isLast) {
      audioPlayer.anounceEndOfWorkout();
      emitCurrent();
      return;
    }
    restBegan = true;
    await audioPlayer.anounceEndOfExercise(current, _workout.restTime);

    currentRestStartedAt = DateTime.now().millisecondsSinceEpoch;

    // Emiting rest state.
    emitCurrent(restLeft: _workout.restTime);

    // Rest timer.
    restTimer = PeriodicPausableTimer(Duration(milliseconds: 100), () {
      restTimer!
        ..reset()
        ..start();
      if (restSecondLeft! <= 0) {
        // Rest ended.
        restBegan = false;
        exerciseTracker.next().then((value) {
          // Goes to the next exercise.
          startExerciseForCurrent();
          restTimer = null;
        });
        restTimer!.cancel(); // Cancel the timer (to prevent executing this code another time)
      }
      emitCurrent();
    }, isPaused);
  }

  /// Cancels the rest timer.
  void _cancelRestTimer() {
    currentRestStartedAt = null;
    restBegan = false;
    try {
      restTimer!.cancel();
    } catch (Exception) {
      // Catching "Null check operator used on a null value".
      // We can't just check if the value is null and then cancel the timer,
      // because between the moment when we looked and the moment when we
      // actually cancel, the value might have become null (due to the rest time
      // ending, if THE ******* USER TAPED THE NEXT BUTTON RIGHT AT THE END OF
      // REST TIME).
    }
  }

  void goStraightToNext() {
    _cancelRestTimer();
    _imageService.stop();
    exerciseTracker.next().then((value) => {startExerciseForCurrent()});
  }

  /// Start the exercise set as "current". This is called when the exercise just
  /// got set as current and needs to be started.
  ///
  /// Reset the set value.
  Future<void> startExerciseForCurrent() async {
    if (current.reps == null && current.length == null) {
      throw "Unknown exercise type. Both length and reps parameters are null for object ${exerciseTracker.current}";
    }
    emitCurrent();
    await audioPlayer.announceExercise(current);
    print("aftere announce");
    currentSetCount = 1;
    startSetForCurrentExercise();
  }

  /// Called when the current set ended. The function then does different things
  /// depending on the current state.
  Future<void> finishedSet() async {
    _imageService.stop();
    if (exerciseSetTimer != null) {
      exerciseSetTimer!.cancel();
      exerciseSetTimer = null;
    }
    // Increasing the set count.
    if (current.sets < currentSetCount + 1) {
      // All sets are finished. Switching to next exercise.
      finishedExercise();
    } else {
      currentSetCount += 1;
      startSetForCurrentExercise();
    }
  }

  /// Start the set.
  ///
  /// Reset the rep value.
  Future<void> startSetForCurrentExercise() async {
    print("start set for current");
    final length = current.length;
    currentRepCount = 0;

    // Emit the initial state.
    emitCurrent();
    // Announce set.
    if (currentSetCount != 1) {
      await audioPlayer.anounceNextSet(current, currentSetCount);
    }

    currentSetStartedAt = DateTime.now().millisecondsSinceEpoch;
    print("starting start for");
    _imageService.startFor(current, (imageUrl) {
      print("Emiting image from start for");
      emitCurrent(imageUrl: imageUrl);
    });
    if (length != null) {
      // Length type exercise.
      exerciseSetTimer = PeriodicPausableTimer(Duration(milliseconds: 100), () {
        if (secondsLeft! <= 0) {
          // The set ends now.
          exerciseSetTimer!.cancel();
          exerciseSetTimer = null;
          finishedSet();
        }
        print("emiting from timer");
        emitCurrent(imageUrl: _imageService.currentImage);
        exerciseSetTimer!
          ..reset()
          ..start();
      }, isPaused);
    } else {
      if (current.repetitionLength != null) {
        // The app needs to say each rep.
        exerciseSetTimer = PeriodicPausableTimer(Duration(milliseconds: (current.repetitionLength! * 1000).floor()), () async {
          exerciseSetTimer!
            ..reset()
            ..start();
          currentRepCount = currentRepCount! +
              1; // This variable need to be set before announcing the number. Because in some cases, due to the asynchronity of the programm bugs may occur.
          await audioPlayer.anounceNumber(currentRepCount!);
          if (currentRepCount! >= current.reps!) {
            // The set ends now.
            exerciseSetTimer!.cancel();
            exerciseSetTimer = null;
            finishedSet();
          }
        }, isPaused);
      }
    }
  }

  /// Start the workout.
  ///
  /// Emit the first states and starts the required timers.
  Future<void> _startWorkout() async {
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
    currentSetCount = 1;
    if (exerciseSetTimer != null) {
      exerciseSetTimer!.cancel();
      exerciseSetTimer = null;
    }
    currentSetStartedAt = null;

    if (current.reps != null && current.repetitionLength == null && restBegan != true) {
      // Starts rest time.
      audioPlayer.stop();
      finishedExercise();
    } else {
      // Jumps to next exercise (the user didn't complete the current exercise
      // so we assume he just wants to skip straight to the next one).
      audioPlayer.stop();
      goStraightToNext();
    }
  }

  /// Goes back to the previous exercise.
  previousButtonPressed() {
    currentSetCount = 1;
    currentSetStartedAt = null;
    audioPlayer.stop();
    _imageService.stop();
    _cancelRestTimer();
    if (exerciseSetTimer != null) {
      exerciseSetTimer!.cancel();
      exerciseSetTimer = null;
    }
    exerciseTracker.previous().then((value) => {startExerciseForCurrent()});
  }

  /// The button for quitting the current workout is pressed.
  backButtonPressed() {
    audioPlayer.stop();
    _imageService.stop();
    _cancelRestTimer();
    if (exerciseSetTimer != null) {
      exerciseSetTimer!.cancel();
    }
  }

  /// The function thats gets called when the user presses the pause button.
  ///
  /// The pause button includes the actual pause button but the play button too
  /// (which appear after the pause button was clicked once)
  pauseButtonPressed() {
    print("pause pressed");
    if (isPaused) {
      // Unpause
      int pauseDuration = (DateTime.now().millisecondsSinceEpoch - pauseStartedAt!);
      if (currentSetStartedAt != null) {
        currentSetStartedAt = currentSetStartedAt! + pauseDuration;
      }
      if (currentRestStartedAt != null) {
        currentRestStartedAt = currentRestStartedAt! + pauseDuration;
      }
      try {
        restTimer!.start();
      } on Error catch (_) {}
      try {
        exerciseSetTimer!.start();
      } on Error catch (_) {}
      _imageService.resume();
      isPaused = false;
      emitCurrent(imageUrl: _imageService.currentExercise == null ? null : _imageService.currentImage);
    } else {
      // Pause
      try {
        restTimer!.pause();
      } on Error catch (_) {}
      try {
        exerciseSetTimer!.pause();
      } on Error catch (_) {}
      _imageService.pause();
      pauseStartedAt = DateTime.now().millisecondsSinceEpoch;
      isPaused = true;
      emitCurrent(imageUrl: _imageService.currentExercise == null ? null : _imageService.currentImage);
    }
  }

  /// Emit the current exercise state.
  ///
  /// - imageUrl : Url of the image to display. Optional, if not provided then
  /// fetches the image url from the imageService by asking for the first image.
  /// - restSecondsLeft : Number of seconds left for the rest. If not provided then
  /// gets the number of seconds left from the [restSecondLeft] property.
  emitCurrent({String? imageUrl, int? restLeft}) {
    assert((restLeft != null) || (restLeft == null && restSecondLeft != null) || (restLeft == null && !restBegan));
    if (restBegan) {
      emit(OnGoingWorkoutState.Rest(
          restLeft == null ? restSecondLeft! : restLeft, exerciseTracker.exerciseIndex, isPaused));
    } else {
      String? image = imageUrl;
      if (image == null) {
        // No image provided. Will get the first exercise for the current exercise.
        image = _imageService.firstImageFor(current);
      }
      emit(OnGoingWorkoutState.ExerciseInProgress(
          exerciseTracker.exerciseIndex, image, exerciseTracker.current.name, currentSetCount, current.sets, isPaused,
          repCount: current.reps, secondsLeft: secondsLeft));
    }
  }
}
