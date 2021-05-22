part of 'workout_choice_cubit.dart';

@freezed
class WorkoutChoiceState with _$WorkoutChoiceState {
  const factory WorkoutChoiceState.initial() = _Initial;

  /// - names : Workout's names. The user can pick one.
  /// - workoutChosen : When user picked a workout this variable becomes not null
  /// and contains the chosen workout.
  factory WorkoutChoiceState(List names, {Workout? workoutChosen}) =
      _WorkoutChoiceState;
}
