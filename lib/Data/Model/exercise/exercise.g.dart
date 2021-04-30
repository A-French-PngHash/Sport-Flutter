// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Exercise _$_$_ExerciseFromJson(Map<String, dynamic> json) {
  return _$_Exercise(
    json['name'] as String,
    json['imagesCount'] as int,
    length: json['length'] as int?,
    repetitionLength: (json['repetitionLength'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_ExerciseToJson(_$_Exercise instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imagesCount': instance.imagesCount,
      'length': instance.length,
      'repetitionLength': instance.repetitionLength,
    };
