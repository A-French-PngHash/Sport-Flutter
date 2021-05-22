// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Workout _$_$_WorkoutFromJson(Map<String, dynamic> json) {
  return _$_Workout(
    json['name'] as String,
    (json['exercises'] as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList(),
    json['restTime'] as int,
    json['workoutType'] as String,
  );
}

Map<String, dynamic> _$_$_WorkoutToJson(_$_Workout instance) =>
    <String, dynamic>{
      'name': instance.name,
      'exercises': instance.exercises,
      'restTime': instance.restTime,
      'workoutType': instance.workoutType,
    };
