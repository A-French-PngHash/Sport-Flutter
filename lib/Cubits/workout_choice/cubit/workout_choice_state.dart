part of 'workout_choice_cubit.dart';

@freezed
abstract class WorkoutChoiceState with _$WorkoutChoiceState {
  const factory WorkoutChoiceState.initial() = _Initial;
  factory WorkoutChoiceState(List names) = _WorkoutChoiceState;
}
