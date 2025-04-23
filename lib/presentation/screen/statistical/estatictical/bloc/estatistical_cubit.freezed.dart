// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estatistical_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EStatisticalState {
  Result<PaginationResponse<LastedLogDataResponse>> get resultChart =>
      throw _privateConstructorUsedError;
  ChartElectricRequest get request => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  int get meterId => throw _privateConstructorUsedError;
  List<SalesData> get loadPowers => throw _privateConstructorUsedError;

  /// Create a copy of EStatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EStatisticalStateCopyWith<EStatisticalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EStatisticalStateCopyWith<$Res> {
  factory $EStatisticalStateCopyWith(
          EStatisticalState value, $Res Function(EStatisticalState) then) =
      _$EStatisticalStateCopyWithImpl<$Res, EStatisticalState>;
  @useResult
  $Res call(
      {Result<PaginationResponse<LastedLogDataResponse>> resultChart,
      ChartElectricRequest request,
      DateTime dateTime,
      int meterId,
      List<SalesData> loadPowers});

  $ResultCopyWith<PaginationResponse<LastedLogDataResponse>, $Res>
      get resultChart;
  $ChartElectricRequestCopyWith<$Res> get request;
}

/// @nodoc
class _$EStatisticalStateCopyWithImpl<$Res, $Val extends EStatisticalState>
    implements $EStatisticalStateCopyWith<$Res> {
  _$EStatisticalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EStatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultChart = null,
    Object? request = null,
    Object? dateTime = null,
    Object? meterId = null,
    Object? loadPowers = null,
  }) {
    return _then(_value.copyWith(
      resultChart: null == resultChart
          ? _value.resultChart
          : resultChart // ignore: cast_nullable_to_non_nullable
              as Result<PaginationResponse<LastedLogDataResponse>>,
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as ChartElectricRequest,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      meterId: null == meterId
          ? _value.meterId
          : meterId // ignore: cast_nullable_to_non_nullable
              as int,
      loadPowers: null == loadPowers
          ? _value.loadPowers
          : loadPowers // ignore: cast_nullable_to_non_nullable
              as List<SalesData>,
    ) as $Val);
  }

  /// Create a copy of EStatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResultCopyWith<PaginationResponse<LastedLogDataResponse>, $Res>
      get resultChart {
    return $ResultCopyWith<PaginationResponse<LastedLogDataResponse>, $Res>(
        _value.resultChart, (value) {
      return _then(_value.copyWith(resultChart: value) as $Val);
    });
  }

  /// Create a copy of EStatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChartElectricRequestCopyWith<$Res> get request {
    return $ChartElectricRequestCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StatisticalStateImplCopyWith<$Res>
    implements $EStatisticalStateCopyWith<$Res> {
  factory _$$StatisticalStateImplCopyWith(_$StatisticalStateImpl value,
          $Res Function(_$StatisticalStateImpl) then) =
      __$$StatisticalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Result<PaginationResponse<LastedLogDataResponse>> resultChart,
      ChartElectricRequest request,
      DateTime dateTime,
      int meterId,
      List<SalesData> loadPowers});

  @override
  $ResultCopyWith<PaginationResponse<LastedLogDataResponse>, $Res>
      get resultChart;
  @override
  $ChartElectricRequestCopyWith<$Res> get request;
}

/// @nodoc
class __$$StatisticalStateImplCopyWithImpl<$Res>
    extends _$EStatisticalStateCopyWithImpl<$Res, _$StatisticalStateImpl>
    implements _$$StatisticalStateImplCopyWith<$Res> {
  __$$StatisticalStateImplCopyWithImpl(_$StatisticalStateImpl _value,
      $Res Function(_$StatisticalStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EStatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultChart = null,
    Object? request = null,
    Object? dateTime = null,
    Object? meterId = null,
    Object? loadPowers = null,
  }) {
    return _then(_$StatisticalStateImpl(
      resultChart: null == resultChart
          ? _value.resultChart
          : resultChart // ignore: cast_nullable_to_non_nullable
              as Result<PaginationResponse<LastedLogDataResponse>>,
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as ChartElectricRequest,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      meterId: null == meterId
          ? _value.meterId
          : meterId // ignore: cast_nullable_to_non_nullable
              as int,
      loadPowers: null == loadPowers
          ? _value._loadPowers
          : loadPowers // ignore: cast_nullable_to_non_nullable
              as List<SalesData>,
    ));
  }
}

/// @nodoc

class _$StatisticalStateImpl implements _StatisticalState {
  const _$StatisticalStateImpl(
      {required this.resultChart,
      required this.request,
      required this.dateTime,
      required this.meterId,
      final List<SalesData> loadPowers = const []})
      : _loadPowers = loadPowers;

  @override
  final Result<PaginationResponse<LastedLogDataResponse>> resultChart;
  @override
  final ChartElectricRequest request;
  @override
  final DateTime dateTime;
  @override
  final int meterId;
  final List<SalesData> _loadPowers;
  @override
  @JsonKey()
  List<SalesData> get loadPowers {
    if (_loadPowers is EqualUnmodifiableListView) return _loadPowers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_loadPowers);
  }

  @override
  String toString() {
    return 'EStatisticalState(resultChart: $resultChart, request: $request, dateTime: $dateTime, meterId: $meterId, loadPowers: $loadPowers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatisticalStateImpl &&
            (identical(other.resultChart, resultChart) ||
                other.resultChart == resultChart) &&
            (identical(other.request, request) || other.request == request) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.meterId, meterId) || other.meterId == meterId) &&
            const DeepCollectionEquality()
                .equals(other._loadPowers, _loadPowers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, resultChart, request, dateTime,
      meterId, const DeepCollectionEquality().hash(_loadPowers));

  /// Create a copy of EStatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatisticalStateImplCopyWith<_$StatisticalStateImpl> get copyWith =>
      __$$StatisticalStateImplCopyWithImpl<_$StatisticalStateImpl>(
          this, _$identity);
}

abstract class _StatisticalState implements EStatisticalState {
  const factory _StatisticalState(
      {required final Result<PaginationResponse<LastedLogDataResponse>>
          resultChart,
      required final ChartElectricRequest request,
      required final DateTime dateTime,
      required final int meterId,
      final List<SalesData> loadPowers}) = _$StatisticalStateImpl;

  @override
  Result<PaginationResponse<LastedLogDataResponse>> get resultChart;
  @override
  ChartElectricRequest get request;
  @override
  DateTime get dateTime;
  @override
  int get meterId;
  @override
  List<SalesData> get loadPowers;

  /// Create a copy of EStatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatisticalStateImplCopyWith<_$StatisticalStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
