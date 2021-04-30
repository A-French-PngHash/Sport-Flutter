// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return _Exercise.fromJson(json);
}

/// @nodoc
class _$ExerciseTearOff {
  const _$ExerciseTearOff();

  _Exercise call(String name, int imagesCount,
      {int? length, double? repetitionLength}) {
    return _Exercise(
      name,
      imagesCount,
      length: length,
      repetitionLength: repetitionLength,
    );
  }

  Exercise fromJson(Map<String, Object> json) {
    return Exercise.fromJson(json);
  }
}

/// @nodoc
const $Exercise = _$ExerciseTearOff();

/// @nodoc
mixin _$Exercise {
  String get name => throw _privateConstructorUsedError;
  int get imagesCount => throw _privateConstructorUsedError;
  int? get length => throw _privateConstructorUsedError;
  double? get repetitionLength => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res>;
  $Res call(
      {String name, int imagesCount, int? length, double? repetitionLength});
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res> implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  final Exercise _value;
  // ignore: unused_field
  final $Res Function(Exercise) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? imagesCount = freezed,
    Object? length = freezed,
    Object? repetitionLength = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imagesCount: imagesCount == freezed
          ? _value.imagesCount
          : imagesCount // ignore: cast_nullable_to_non_nullable
              as int,
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
      repetitionLength: repetitionLength == freezed
          ? _value.repetitionLength
          : repetitionLength // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
abstract class _$ExerciseCopyWith<$Res> implements $ExerciseCopyWith<$Res> {
  factory _$ExerciseCopyWith(_Exercise value, $Res Function(_Exercise) then) =
      __$ExerciseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name, int imagesCount, int? length, double? repetitionLength});
}

/// @nodoc
class __$ExerciseCopyWithImpl<$Res> extends _$ExerciseCopyWithImpl<$Res>
    implements _$ExerciseCopyWith<$Res> {
  __$ExerciseCopyWithImpl(_Exercise _value, $Res Function(_Exercise) _then)
      : super(_value, (v) => _then(v as _Exercise));

  @override
  _Exercise get _value => super._value as _Exercise;

  @override
  $Res call({
    Object? name = freezed,
    Object? imagesCount = freezed,
    Object? length = freezed,
    Object? repetitionLength = freezed,
  }) {
    return _then(_Exercise(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imagesCount == freezed
          ? _value.imagesCount
          : imagesCount // ignore: cast_nullable_to_non_nullable
              as int,
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
      repetitionLength: repetitionLength == freezed
          ? _value.repetitionLength
          : repetitionLength // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Exercise implements _Exercise {
  _$_Exercise(this.name, this.imagesCount,
      {this.length, this.repetitionLength});

  factory _$_Exercise.fromJson(Map<String, dynamic> json) =>
      _$_$_ExerciseFromJson(json);

  @override
  final String name;
  @override
  final int imagesCount;
  @override
  final int? length;
  @override
  final double? repetitionLength;

  @override
  String toString() {
    return 'Exercise(name: $name, imagesCount: $imagesCount, length: $length, repetitionLength: $repetitionLength)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Exercise &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.imagesCount, imagesCount) ||
                const DeepCollectionEquality()
                    .equals(other.imagesCount, imagesCount)) &&
            (identical(other.length, length) ||
                const DeepCollectionEquality().equals(other.length, length)) &&
            (identical(other.repetitionLength, repetitionLength) ||
                const DeepCollectionEquality()
                    .equals(other.repetitionLength, repetitionLength)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(imagesCount) ^
      const DeepCollectionEquality().hash(length) ^
      const DeepCollectionEquality().hash(repetitionLength);

  @JsonKey(ignore: true)
  @override
  _$ExerciseCopyWith<_Exercise> get copyWith =>
      __$ExerciseCopyWithImpl<_Exercise>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ExerciseToJson(this);
  }
}

abstract class _Exercise implements Exercise {
  factory _Exercise(String name, int imagesCount,
      {int? length, double? repetitionLength}) = _$_Exercise;

  factory _Exercise.fromJson(Map<String, dynamic> json) = _$_Exercise.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  int get imagesCount => throw _privateConstructorUsedError;
  @override
  int? get length => throw _privateConstructorUsedError;
  @override
  double? get repetitionLength => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ExerciseCopyWith<_Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}
