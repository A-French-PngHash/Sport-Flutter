part of 'on_going_workout_cubit.dart';

@freezed
class OnGoingWorkoutState with _$OnGoingWorkoutState {
  const factory OnGoingWorkoutState.initial() = _Initial;

  /// Rest time.
  /// 
  /// - currentExerciseIndex : The index of the exercise currently being done. Starts at 1. This parameter is specified even during rest time because it is necessary in order to display the progress bar.
  /// - secondsLeft: Number of seconds left before the next exercise.
  factory OnGoingWorkoutState.Rest(int secondsLeft, int currentExerciseIndex, bool paused) = _Rest;

  /// Exercise in progress.
  /// 
  /// - currentExerciseIndex : The index of the exercise currently being done. Starts at 1.
  /// - imgUrl : Local url of the image to be displayed.
  /// - exerciseName : Name of the current exercise.
  /// - setCount : Number of set for this exercise.
  /// - currentSet : Current set the user is doing.
  /// - paused : Whether the workout is currently paused.
  /// - repCount : Number of rep for this exercise. Optional because some exercise have a duration instead of a number of reps.
  /// - secondsLeft : Number of seconds left. Is optional because some exercise don't have a set number of seconds.
  factory OnGoingWorkoutState.ExerciseInProgress(int currentExerciseIndex, String imgUrl, String exerciseName, int setCount, int currentSet, bool paused, {int? repCount, int? secondsLeft}) = _Exercise;
}
