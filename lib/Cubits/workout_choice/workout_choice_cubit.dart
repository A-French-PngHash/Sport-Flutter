import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sport/Data/Model/workout/workout.dart';
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
    final names = await _workoutRepository.workoutNameList;
    emit(WorkoutChoiceState(names));
  }

  /// The user selected a workout.
  ///
  /// - name : Name of the selected workout.
  void selectedWorkout(String name) async {
    final workoutChosen = await _workoutRepository.workoutFromName(name);
    emit(WorkoutChoiceState(
      await _workoutRepository.workoutNameList,
      workoutChosen: workoutChosen,
    ));
  }
}
