// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'workout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return _Workout.fromJson(json);
}

/// @nodoc
class _$WorkoutTearOff {
  const _$WorkoutTearOff();

  _Workout call(String name, List<Map<String, dynamic>> exercises, int restTime,
      String workoutType) {
    return _Workout(
      name,
      exercises,
      restTime,
      workoutType,
    );
  }

  Workout fromJson(Map<String, Object> json) {
    return Workout.fromJson(json);
  }
}

/// @nodoc
const $Workout = _$WorkoutTearOff();

/// @nodoc
mixin _$Workout {
  String get name => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get exercises =>
      throw _privateConstructorUsedError;
  int get restTime => throw _privateConstructorUsedError;
  String get workoutType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkoutCopyWith<Workout> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutCopyWith<$Res> {
  factory $WorkoutCopyWith(Workout value, $Res Function(Workout) then) =
      _$WorkoutCopyWithImpl<$Res>;
  $Res call(
      {String name,
      List<Map<String, dynamic>> exercises,
      int restTime,
      String workoutType});
}

/// @nodoc
class _$WorkoutCopyWithImpl<$Res> implements $WorkoutCopyWith<$Res> {
  _$WorkoutCopyWithImpl(this._value, this._then);

  final Workout _value;
  // ignore: unused_field
  final $Res Function(Workout) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? exercises = freezed,
    Object? restTime = freezed,
    Object? workoutType = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exercises: exercises == freezed
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      restTime: restTime == freezed
          ? _value.restTime
          : restTime // ignore: cast_nullable_to_non_nullable
              as int,
      workoutType: workoutType == freezed
          ? _value.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$WorkoutCopyWith<$Res> implements $WorkoutCopyWith<$Res> {
  factory _$WorkoutCopyWith(_Workout value, $Res Function(_Workout) then) =
      __$WorkoutCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      List<Map<String, dynamic>> exercises,
      int restTime,
      String workoutType});
}

/// @nodoc
class __$WorkoutCopyWithImpl<$Res> extends _$WorkoutCopyWithImpl<$Res>
    implements _$WorkoutCopyWith<$Res> {
  __$WorkoutCopyWithImpl(_Workout _value, $Res Function(_Workout) _then)
      : super(_value, (v) => _then(v as _Workout));

  @override
  _Workout get _value => super._value as _Workout;

  @override
  $Res call({
    Object? name = freezed,
    Object? exercises = freezed,
    Object? restTime = freezed,
    Object? workoutType = freezed,
  }) {
    return _then(_Workout(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exercises == freezed
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      restTime == freezed
          ? _value.restTime
          : restTime // ignore: cast_nullable_to_non_nullable
              as int,
      workoutType == freezed
          ? _value.workoutType
          : workoutType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Workout implements _Workout {
  _$_Workout(this.name, this.exercises, this.restTime, this.workoutType);

  factory _$_Workout.fromJson(Map<String, dynamic> json) =>
      _$_$_WorkoutFromJson(json);

  @override
  final String name;
  @override
  final List<Map<String, dynamic>> exercises;
  @override
  final int restTime;
  @override
  final String workoutType;

  @override
  String toString() {
    return 'Workout(name: $name, exercises: $exercises, restTime: $restTime, workoutType: $workoutType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Workout &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.exercises, exercises) ||
                const DeepCollectionEquality()
                    .equals(other.exercises, exercises)) &&
            (identical(other.restTime, restTime) ||
                const DeepCollectionEquality()
                    .equals(other.restTime, restTime)) &&
            (identical(other.workoutType, workoutType) ||
                const DeepCollectionEquality()
                    .equals(other.workoutType, workoutType)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(exercises) ^
      const DeepCollectionEquality().hash(restTime) ^
      const DeepCollectionEquality().hash(workoutType);

  @JsonKey(ignore: true)
  @override
  _$WorkoutCopyWith<_Workout> get copyWith =>
      __$WorkoutCopyWithImpl<_Workout>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_WorkoutToJson(this);
  }
}

abstract class _Workout implements Workout {
  factory _Workout(String name, List<Map<String, dynamic>> exercises,
      int restTime, String workoutType) = _$_Workout;

  factory _Workout.fromJson(Map<String, dynamic> json) = _$_Workout.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  List<Map<String, dynamic>> get exercises =>
      throw _privateConstructorUsedError;
  @override
  int get restTime => throw _privateConstructorUsedError;
  @override
  String get workoutType => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WorkoutCopyWith<_Workout> get copyWith =>
      throw _privateConstructorUsedError;
}
