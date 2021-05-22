import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout.freezed.dart';
part 'workout.g.dart';

@freezed
class Workout with _$Workout {
  factory Workout(String name, List<Map<String, dynamic>> exercises, int restTime, String workoutType) = _Workout;
  
  factory Workout.fromJson(Map<String, dynamic> json) => _$WorkoutFromJson(json);
}
