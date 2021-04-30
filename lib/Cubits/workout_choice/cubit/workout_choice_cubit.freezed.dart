// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'workout_choice_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WorkoutChoiceStateTearOff {
  const _$WorkoutChoiceStateTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _WorkoutChoiceState call(List<dynamic> names) {
    return _WorkoutChoiceState(
      names,
    );
  }
}

/// @nodoc
const $WorkoutChoiceState = _$WorkoutChoiceStateTearOff();

/// @nodoc
mixin _$WorkoutChoiceState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<dynamic> names) $default, {
    required TResult Function() initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<dynamic> names)? $default, {
    TResult Function()? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_WorkoutChoiceState value) $default, {
    required TResult Function(_Initial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_WorkoutChoiceState value)? $default, {
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutChoiceStateCopyWith<$Res> {
  factory $WorkoutChoiceStateCopyWith(
          WorkoutChoiceState value, $Res Function(WorkoutChoiceState) then) =
      _$WorkoutChoiceStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$WorkoutChoiceStateCopyWithImpl<$Res>
    implements $WorkoutChoiceStateCopyWith<$Res> {
  _$WorkoutChoiceStateCopyWithImpl(this._value, this._then);

  final WorkoutChoiceState _value;
  // ignore: unused_field
  final $Res Function(WorkoutChoiceState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res>
    extends _$WorkoutChoiceStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'WorkoutChoiceState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<dynamic> names) $default, {
    required TResult Function() initial,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<dynamic> names)? $default, {
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_WorkoutChoiceState value) $default, {
    required TResult Function(_Initial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_WorkoutChoiceState value)? $default, {
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements WorkoutChoiceState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$WorkoutChoiceStateCopyWith<$Res> {
  factory _$WorkoutChoiceStateCopyWith(
          _WorkoutChoiceState value, $Res Function(_WorkoutChoiceState) then) =
      __$WorkoutChoiceStateCopyWithImpl<$Res>;
  $Res call({List<dynamic> names});
}

/// @nodoc
class __$WorkoutChoiceStateCopyWithImpl<$Res>
    extends _$WorkoutChoiceStateCopyWithImpl<$Res>
    implements _$WorkoutChoiceStateCopyWith<$Res> {
  __$WorkoutChoiceStateCopyWithImpl(
      _WorkoutChoiceState _value, $Res Function(_WorkoutChoiceState) _then)
      : super(_value, (v) => _then(v as _WorkoutChoiceState));

  @override
  _WorkoutChoiceState get _value => super._value as _WorkoutChoiceState;

  @override
  $Res call({
    Object? names = freezed,
  }) {
    return _then(_WorkoutChoiceState(
      names == freezed
          ? _value.names
          : names // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc

class _$_WorkoutChoiceState implements _WorkoutChoiceState {
  _$_WorkoutChoiceState(this.names);

  @override
  final List<dynamic> names;

  @override
  String toString() {
    return 'WorkoutChoiceState(names: $names)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WorkoutChoiceState &&
            (identical(other.names, names) ||
                const DeepCollectionEquality().equals(other.names, names)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(names);

  @JsonKey(ignore: true)
  @override
  _$WorkoutChoiceStateCopyWith<_WorkoutChoiceState> get copyWith =>
      __$WorkoutChoiceStateCopyWithImpl<_WorkoutChoiceState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<dynamic> names) $default, {
    required TResult Function() initial,
  }) {
    return $default(names);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<dynamic> names)? $default, {
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(names);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_WorkoutChoiceState value) $default, {
    required TResult Function(_Initial value) initial,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_WorkoutChoiceState value)? $default, {
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _WorkoutChoiceState implements WorkoutChoiceState {
  factory _WorkoutChoiceState(List<dynamic> names) = _$_WorkoutChoiceState;

  List<dynamic> get names => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$WorkoutChoiceStateCopyWith<_WorkoutChoiceState> get copyWith =>
      throw _privateConstructorUsedError;
}
