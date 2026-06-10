// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'EnergyConsumptionChartResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EnergyConsumptionChartResponse _$EnergyConsumptionChartResponseFromJson(
    Map<String, dynamic> json) {
  return _EnergyConsumptionChartResponse.fromJson(json);
}

/// @nodoc
mixin _$EnergyConsumptionChartResponse {
  List<String> get labels => throw _privateConstructorUsedError;
  List<double> get currentPeriodData => throw _privateConstructorUsedError;
  List<double> get previousPeriodData => throw _privateConstructorUsedError;

  /// Serializes this EnergyConsumptionChartResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EnergyConsumptionChartResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EnergyConsumptionChartResponseCopyWith<EnergyConsumptionChartResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnergyConsumptionChartResponseCopyWith<$Res> {
  factory $EnergyConsumptionChartResponseCopyWith(
          EnergyConsumptionChartResponse value,
          $Res Function(EnergyConsumptionChartResponse) then) =
      _$EnergyConsumptionChartResponseCopyWithImpl<$Res,
          EnergyConsumptionChartResponse>;
  @useResult
  $Res call(
      {List<String> labels,
      List<double> currentPeriodData,
      List<double> previousPeriodData});
}

/// @nodoc
class _$EnergyConsumptionChartResponseCopyWithImpl<$Res,
        $Val extends EnergyConsumptionChartResponse>
    implements $EnergyConsumptionChartResponseCopyWith<$Res> {
  _$EnergyConsumptionChartResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnergyConsumptionChartResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? labels = null,
    Object? currentPeriodData = null,
    Object? previousPeriodData = null,
  }) {
    return _then(_value.copyWith(
      labels: null == labels
          ? _value.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentPeriodData: null == currentPeriodData
          ? _value.currentPeriodData
          : currentPeriodData // ignore: cast_nullable_to_non_nullable
              as List<double>,
      previousPeriodData: null == previousPeriodData
          ? _value.previousPeriodData
          : previousPeriodData // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EnergyConsumptionChartResponseImplCopyWith<$Res>
    implements $EnergyConsumptionChartResponseCopyWith<$Res> {
  factory _$$EnergyConsumptionChartResponseImplCopyWith(
          _$EnergyConsumptionChartResponseImpl value,
          $Res Function(_$EnergyConsumptionChartResponseImpl) then) =
      __$$EnergyConsumptionChartResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> labels,
      List<double> currentPeriodData,
      List<double> previousPeriodData});
}

/// @nodoc
class __$$EnergyConsumptionChartResponseImplCopyWithImpl<$Res>
    extends _$EnergyConsumptionChartResponseCopyWithImpl<$Res,
        _$EnergyConsumptionChartResponseImpl>
    implements _$$EnergyConsumptionChartResponseImplCopyWith<$Res> {
  __$$EnergyConsumptionChartResponseImplCopyWithImpl(
      _$EnergyConsumptionChartResponseImpl _value,
      $Res Function(_$EnergyConsumptionChartResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnergyConsumptionChartResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? labels = null,
    Object? currentPeriodData = null,
    Object? previousPeriodData = null,
  }) {
    return _then(_$EnergyConsumptionChartResponseImpl(
      labels: null == labels
          ? _value._labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentPeriodData: null == currentPeriodData
          ? _value._currentPeriodData
          : currentPeriodData // ignore: cast_nullable_to_non_nullable
              as List<double>,
      previousPeriodData: null == previousPeriodData
          ? _value._previousPeriodData
          : previousPeriodData // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EnergyConsumptionChartResponseImpl
    implements _EnergyConsumptionChartResponse {
  const _$EnergyConsumptionChartResponseImpl(
      {final List<String> labels = const [],
      final List<double> currentPeriodData = const [],
      final List<double> previousPeriodData = const []})
      : _labels = labels,
        _currentPeriodData = currentPeriodData,
        _previousPeriodData = previousPeriodData;

  factory _$EnergyConsumptionChartResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EnergyConsumptionChartResponseImplFromJson(json);

  final List<String> _labels;
  @override
  @JsonKey()
  List<String> get labels {
    if (_labels is EqualUnmodifiableListView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_labels);
  }

  final List<double> _currentPeriodData;
  @override
  @JsonKey()
  List<double> get currentPeriodData {
    if (_currentPeriodData is EqualUnmodifiableListView)
      return _currentPeriodData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentPeriodData);
  }

  final List<double> _previousPeriodData;
  @override
  @JsonKey()
  List<double> get previousPeriodData {
    if (_previousPeriodData is EqualUnmodifiableListView)
      return _previousPeriodData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previousPeriodData);
  }

  @override
  String toString() {
    return 'EnergyConsumptionChartResponse(labels: $labels, currentPeriodData: $currentPeriodData, previousPeriodData: $previousPeriodData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnergyConsumptionChartResponseImpl &&
            const DeepCollectionEquality().equals(other._labels, _labels) &&
            const DeepCollectionEquality()
                .equals(other._currentPeriodData, _currentPeriodData) &&
            const DeepCollectionEquality()
                .equals(other._previousPeriodData, _previousPeriodData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_labels),
      const DeepCollectionEquality().hash(_currentPeriodData),
      const DeepCollectionEquality().hash(_previousPeriodData));

  /// Create a copy of EnergyConsumptionChartResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnergyConsumptionChartResponseImplCopyWith<
          _$EnergyConsumptionChartResponseImpl>
      get copyWith => __$$EnergyConsumptionChartResponseImplCopyWithImpl<
          _$EnergyConsumptionChartResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EnergyConsumptionChartResponseImplToJson(
      this,
    );
  }
}

abstract class _EnergyConsumptionChartResponse
    implements EnergyConsumptionChartResponse {
  const factory _EnergyConsumptionChartResponse(
          {final List<String> labels,
          final List<double> currentPeriodData,
          final List<double> previousPeriodData}) =
      _$EnergyConsumptionChartResponseImpl;

  factory _EnergyConsumptionChartResponse.fromJson(Map<String, dynamic> json) =
      _$EnergyConsumptionChartResponseImpl.fromJson;

  @override
  List<String> get labels;
  @override
  List<double> get currentPeriodData;
  @override
  List<double> get previousPeriodData;

  /// Create a copy of EnergyConsumptionChartResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnergyConsumptionChartResponseImplCopyWith<
          _$EnergyConsumptionChartResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
