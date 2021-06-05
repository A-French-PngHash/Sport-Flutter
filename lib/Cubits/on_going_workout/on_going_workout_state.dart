part of 'on_going_workout_cubit.dart';

@freezed
class OnGoingWorkoutState with _$OnGoingWorkoutState {
  const factory OnGoingWorkoutState.initial() = _Initial;

  /// Rest time.
  /// 
  /// - secondsLeft: Number of seconds left before the next exercise.
  factory OnGoingWorkoutState.Rest(int secondsLeft) = _Rest;

  /// Exercise in progress.
  /// 
  /// - imgUrl : Local url of the image to be displayed.
  /// - setCount : Number of set for this exercise.
  /// - currentSet : Current set the user is doing.
  /// - repCount : Number of rep for this exercise. Optional because some exercise have a duration instead of a number of reps.
  /// - secondsLeft : Number of seconds left. Is optional because some exercise don't have a set number of seconds.
  factory OnGoingWorkoutState.ExerciseInProgress(String imgUrl, int setCount, int currentSet, {int? repCount, int? secondsLeft}) = _Exercise;
}
