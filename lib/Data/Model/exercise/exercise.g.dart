// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Exercise _$_$_ExerciseFromJson(Map<String, dynamic> json) {
  return _$_Exercise(
    json['name'] as String,
    json['imagesCount'] as int,
    json['sets'] as int,
    length: json['length'] as int?,
    repetitionLength: (json['repetitionLength'] as num?)?.toDouble(),
    reps: json['reps'] as int?,
  );
}

Map<String, dynamic> _$_$_ExerciseToJson(_$_Exercise instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imagesCount': instance.imagesCount,
      'sets': instance.sets,
      'length': instance.length,
      'repetitionLength': instance.repetitionLength,
      'reps': instance.reps,
    };
