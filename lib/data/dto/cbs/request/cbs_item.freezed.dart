// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cbs_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CbsItem _$CbsItemFromJson(Map<String, dynamic> json) {
  return _CbsItem.fromJson(json);
}

/// @nodoc
mixin _$CbsItem {
  String get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this CbsItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CbsItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CbsItemCopyWith<CbsItem> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CbsItemCopyWith<$Res> {
  factory $CbsItemCopyWith(CbsItem value, $Res Function(CbsItem) then) =
      _$CbsItemCopyWithImpl<$Res, CbsItem>;
  @useResult
  $Res call({String id, String status});
}

/// @nodoc
class _$CbsItemCopyWithImpl<$Res, $Val extends CbsItem>
    implements $CbsItemCopyWith<$Res> {
  _$CbsItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CbsItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CbsItemImplCopyWith<$Res> implements $CbsItemCopyWith<$Res> {
  factory _$$CbsItemImplCopyWith(
          _$CbsItemImpl value, $Res Function(_$CbsItemImpl) then) =
      __$$CbsItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String status});
}

/// @nodoc
class __$$CbsItemImplCopyWithImpl<$Res>
    extends _$CbsItemCopyWithImpl<$Res, _$CbsItemImpl>
    implements _$$CbsItemImplCopyWith<$Res> {
  __$$CbsItemImplCopyWithImpl(
      _$CbsItemImpl _value, $Res Function(_$CbsItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of CbsItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
  }) {
    return _then(_$CbsItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CbsItemImpl implements _CbsItem {
  const _$CbsItemImpl({required this.id, required this.status});

  factory _$CbsItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CbsItemImplFromJson(json);

  @override
  final String id;
  @override
  final String status;

  @override
  String toString() {
    return 'CbsItem(id: $id, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CbsItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, status);

  /// Create a copy of CbsItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CbsItemImplCopyWith<_$CbsItemImpl> get copyWith =>
      __$$CbsItemImplCopyWithImpl<_$CbsItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CbsItemImplToJson(
      this,
    );
  }
}

abstract class _CbsItem implements CbsItem {
  const factory _CbsItem(
      {required final String id, required final String status}) = _$CbsItemImpl;

  factory _CbsItem.fromJson(Map<String, dynamic> json) = _$CbsItemImpl.fromJson;

  @override
  String get id;
  @override
  String get status;

  /// Create a copy of CbsItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CbsItemImplCopyWith<_$CbsItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
