// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistical_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StatisticalState {
  Result<PaginationResponse<SolarElectricResponse>> get resultSolar =>
      throw _privateConstructorUsedError;
  SolarElectricRequest get request => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  double get totalGridPower => throw _privateConstructorUsedError;
  double get totalProductionPower => throw _privateConstructorUsedError;
  double get totalLoadPower => throw _privateConstructorUsedError;
  List<ChartData> get listOutput => throw _privateConstructorUsedError;
  List<ChartData> get listUsed => throw _privateConstructorUsedError;
  List<SalesData> get gridPowers => throw _privateConstructorUsedError;
  List<SalesData> get productionPowers => throw _privateConstructorUsedError;
  List<SalesData> get loadPowers => throw _privateConstructorUsedError;

  /// Create a copy of StatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatisticalStateCopyWith<StatisticalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticalStateCopyWith<$Res> {
  factory $StatisticalStateCopyWith(
          StatisticalState value, $Res Function(StatisticalState) then) =
      _$StatisticalStateCopyWithImpl<$Res, StatisticalState>;
  @useResult
  $Res call(
      {Result<PaginationResponse<SolarElectricResponse>> resultSolar,
      SolarElectricRequest request,
      DateTime dateTime,
      double totalGridPower,
      double totalProductionPower,
      double totalLoadPower,
      List<ChartData> listOutput,
      List<ChartData> listUsed,
      List<SalesData> gridPowers,
      List<SalesData> productionPowers,
      List<SalesData> loadPowers});

  $ResultCopyWith<PaginationResponse<SolarElectricResponse>, $Res>
      get resultSolar;
  $SolarElectricRequestCopyWith<$Res> get request;
}

/// @nodoc
class _$StatisticalStateCopyWithImpl<$Res, $Val extends StatisticalState>
    implements $StatisticalStateCopyWith<$Res> {
  _$StatisticalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultSolar = null,
    Object? request = null,
    Object? dateTime = null,
    Object? totalGridPower = null,
    Object? totalProductionPower = null,
    Object? totalLoadPower = null,
    Object? listOutput = null,
    Object? listUsed = null,
    Object? gridPowers = null,
    Object? productionPowers = null,
    Object? loadPowers = null,
  }) {
    return _then(_value.copyWith(
      resultSolar: null == resultSolar
          ? _value.resultSolar
          : resultSolar // ignore: cast_nullable_to_non_nullable
              as Result<PaginationResponse<SolarElectricResponse>>,
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as SolarElectricRequest,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalGridPower: null == totalGridPower
          ? _value.totalGridPower
          : totalGridPower // ignore: cast_nullable_to_non_nullable
              as double,
      totalProductionPower: null == totalProductionPower
          ? _value.totalProductionPower
          : totalProductionPower // ignore: cast_nullable_to_non_nullable
              as double,
      totalLoadPower: null == totalLoadPower
          ? _value.totalLoadPower
          : totalLoadPower // ignore: cast_nullable_to_non_nullable
              as double,
      listOutput: null == listOutput
          ? _value.listOutput
          : listOutput // ignore: cast_nullable_to_non_nullable
              as List<ChartData>,
      listUsed: null == listUsed
          ? _value.listUsed
          : listUsed // ignore: cast_nullable_to_non_nullable
              as List<ChartData>,
      gridPowers: null == gridPowers
          ? _value.gridPowers
          : gridPowers // ignore: cast_nullable_to_non_nullable
              as List<SalesData>,
      productionPowers: null == productionPowers
          ? _value.productionPowers
          : productionPowers // ignore: cast_nullable_to_non_nullable
              as List<SalesData>,
      loadPowers: null == loadPowers
          ? _value.loadPowers
          : loadPowers // ignore: cast_nullable_to_non_nullable
              as List<SalesData>,
    ) as $Val);
  }

  /// Create a copy of StatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResultCopyWith<PaginationResponse<SolarElectricResponse>, $Res>
      get resultSolar {
    return $ResultCopyWith<PaginationResponse<SolarElectricResponse>, $Res>(
        _value.resultSolar, (value) {
      return _then(_value.copyWith(resultSolar: value) as $Val);
    });
  }

  /// Create a copy of StatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SolarElectricRequestCopyWith<$Res> get request {
    return $SolarElectricRequestCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StatisticalStateImplCopyWith<$Res>
    implements $StatisticalStateCopyWith<$Res> {
  factory _$$StatisticalStateImplCopyWith(_$StatisticalStateImpl value,
          $Res Function(_$StatisticalStateImpl) then) =
      __$$StatisticalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Result<PaginationResponse<SolarElectricResponse>> resultSolar,
      SolarElectricRequest request,
      DateTime dateTime,
      double totalGridPower,
      double totalProductionPower,
      double totalLoadPower,
      List<ChartData> listOutput,
      List<ChartData> listUsed,
      List<SalesData> gridPowers,
      List<SalesData> productionPowers,
      List<SalesData> loadPowers});

  @override
  $ResultCopyWith<PaginationResponse<SolarElectricResponse>, $Res>
      get resultSolar;
  @override
  $SolarElectricRequestCopyWith<$Res> get request;
}

/// @nodoc
class __$$StatisticalStateImplCopyWithImpl<$Res>
    extends _$StatisticalStateCopyWithImpl<$Res, _$StatisticalStateImpl>
    implements _$$StatisticalStateImplCopyWith<$Res> {
  __$$StatisticalStateImplCopyWithImpl(_$StatisticalStateImpl _value,
      $Res Function(_$StatisticalStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultSolar = null,
    Object? request = null,
    Object? dateTime = null,
    Object? totalGridPower = null,
    Object? totalProductionPower = null,
    Object? totalLoadPower = null,
    Object? listOutput = null,
    Object? listUsed = null,
    Object? gridPowers = null,
    Object? productionPowers = null,
    Object? loadPowers = null,
  }) {
    return _then(_$StatisticalStateImpl(
      resultSolar: null == resultSolar
          ? _value.resultSolar
          : resultSolar // ignore: cast_nullable_to_non_nullable
              as Result<PaginationResponse<SolarElectricResponse>>,
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as SolarElectricRequest,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalGridPower: null == totalGridPower
          ? _value.totalGridPower
          : totalGridPower // ignore: cast_nullable_to_non_nullable
              as double,
      totalProductionPower: null == totalProductionPower
          ? _value.totalProductionPower
          : totalProductionPower // ignore: cast_nullable_to_non_nullable
              as double,
      totalLoadPower: null == totalLoadPower
          ? _value.totalLoadPower
          : totalLoadPower // ignore: cast_nullable_to_non_nullable
              as double,
      listOutput: null == listOutput
          ? _value._listOutput
          : listOutput // ignore: cast_nullable_to_non_nullable
              as List<ChartData>,
      listUsed: null == listUsed
          ? _value._listUsed
          : listUsed // ignore: cast_nullable_to_non_nullable
              as List<ChartData>,
      gridPowers: null == gridPowers
          ? _value._gridPowers
          : gridPowers // ignore: cast_nullable_to_non_nullable
              as List<SalesData>,
      productionPowers: null == productionPowers
          ? _value._productionPowers
          : productionPowers // ignore: cast_nullable_to_non_nullable
              as List<SalesData>,
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
      {required this.resultSolar,
      required this.request,
      required this.dateTime,
      this.totalGridPower = 0,
      this.totalProductionPower = 0,
      this.totalLoadPower = 0,
      final List<ChartData> listOutput = const [],
      final List<ChartData> listUsed = const [],
      final List<SalesData> gridPowers = const [],
      final List<SalesData> productionPowers = const [],
      final List<SalesData> loadPowers = const []})
      : _listOutput = listOutput,
        _listUsed = listUsed,
        _gridPowers = gridPowers,
        _productionPowers = productionPowers,
        _loadPowers = loadPowers;

  @override
  final Result<PaginationResponse<SolarElectricResponse>> resultSolar;
  @override
  final SolarElectricRequest request;
  @override
  final DateTime dateTime;
  @override
  @JsonKey()
  final double totalGridPower;
  @override
  @JsonKey()
  final double totalProductionPower;
  @override
  @JsonKey()
  final double totalLoadPower;
  final List<ChartData> _listOutput;
  @override
  @JsonKey()
  List<ChartData> get listOutput {
    if (_listOutput is EqualUnmodifiableListView) return _listOutput;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listOutput);
  }

  final List<ChartData> _listUsed;
  @override
  @JsonKey()
  List<ChartData> get listUsed {
    if (_listUsed is EqualUnmodifiableListView) return _listUsed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listUsed);
  }

  final List<SalesData> _gridPowers;
  @override
  @JsonKey()
  List<SalesData> get gridPowers {
    if (_gridPowers is EqualUnmodifiableListView) return _gridPowers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gridPowers);
  }

  final List<SalesData> _productionPowers;
  @override
  @JsonKey()
  List<SalesData> get productionPowers {
    if (_productionPowers is EqualUnmodifiableListView)
      return _productionPowers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productionPowers);
  }

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
    return 'StatisticalState(resultSolar: $resultSolar, request: $request, dateTime: $dateTime, totalGridPower: $totalGridPower, totalProductionPower: $totalProductionPower, totalLoadPower: $totalLoadPower, listOutput: $listOutput, listUsed: $listUsed, gridPowers: $gridPowers, productionPowers: $productionPowers, loadPowers: $loadPowers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatisticalStateImpl &&
            (identical(other.resultSolar, resultSolar) ||
                other.resultSolar == resultSolar) &&
            (identical(other.request, request) || other.request == request) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.totalGridPower, totalGridPower) ||
                other.totalGridPower == totalGridPower) &&
            (identical(other.totalProductionPower, totalProductionPower) ||
                other.totalProductionPower == totalProductionPower) &&
            (identical(other.totalLoadPower, totalLoadPower) ||
                other.totalLoadPower == totalLoadPower) &&
            const DeepCollectionEquality()
                .equals(other._listOutput, _listOutput) &&
            const DeepCollectionEquality().equals(other._listUsed, _listUsed) &&
            const DeepCollectionEquality()
                .equals(other._gridPowers, _gridPowers) &&
            const DeepCollectionEquality()
                .equals(other._productionPowers, _productionPowers) &&
            const DeepCollectionEquality()
                .equals(other._loadPowers, _loadPowers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      resultSolar,
      request,
      dateTime,
      totalGridPower,
      totalProductionPower,
      totalLoadPower,
      const DeepCollectionEquality().hash(_listOutput),
      const DeepCollectionEquality().hash(_listUsed),
      const DeepCollectionEquality().hash(_gridPowers),
      const DeepCollectionEquality().hash(_productionPowers),
      const DeepCollectionEquality().hash(_loadPowers));

  /// Create a copy of StatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatisticalStateImplCopyWith<_$StatisticalStateImpl> get copyWith =>
      __$$StatisticalStateImplCopyWithImpl<_$StatisticalStateImpl>(
          this, _$identity);
}

abstract class _StatisticalState implements StatisticalState {
  const factory _StatisticalState(
      {required final Result<PaginationResponse<SolarElectricResponse>>
          resultSolar,
      required final SolarElectricRequest request,
      required final DateTime dateTime,
      final double totalGridPower,
      final double totalProductionPower,
      final double totalLoadPower,
      final List<ChartData> listOutput,
      final List<ChartData> listUsed,
      final List<SalesData> gridPowers,
      final List<SalesData> productionPowers,
      final List<SalesData> loadPowers}) = _$StatisticalStateImpl;

  @override
  Result<PaginationResponse<SolarElectricResponse>> get resultSolar;
  @override
  SolarElectricRequest get request;
  @override
  DateTime get dateTime;
  @override
  double get totalGridPower;
  @override
  double get totalProductionPower;
  @override
  double get totalLoadPower;
  @override
  List<ChartData> get listOutput;
  @override
  List<ChartData> get listUsed;
  @override
  List<SalesData> get gridPowers;
  @override
  List<SalesData> get productionPowers;
  @override
  List<SalesData> get loadPowers;

  /// Create a copy of StatisticalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatisticalStateImplCopyWith<_$StatisticalStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
