import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sport/Data/workout_repository.dart';

part 'workout_choice_state.dart';
part 'workout_choice_cubit.freezed.dart';

class WorkoutChoiceCubit extends Cubit<WorkoutChoiceState> {
  final WorkoutRepository _workoutRepository;

  WorkoutChoiceCubit(this._workoutRepository)
      : super(WorkoutChoiceState.initial()) {
    _loadState();
  }

  void _loadState() async {
    final workouts = await _workoutRepository.fetchWorkoutList();
    var names = [];
    for (final workout in workouts) {
      names.add(workout.name);
    }
    emit(WorkoutChoiceState(names));
  }
}
