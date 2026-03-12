// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MarketState {
  bool get loading => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;

  /// Create a copy of MarketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketStateCopyWith<MarketState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketStateCopyWith<$Res> {
  factory $MarketStateCopyWith(
          MarketState value, $Res Function(MarketState) then) =
      _$MarketStateCopyWithImpl<$Res, MarketState>;
  @useResult
  $Res call({bool loading, List<String> categories});
}

/// @nodoc
class _$MarketStateCopyWithImpl<$Res, $Val extends MarketState>
    implements $MarketStateCopyWith<$Res> {
  _$MarketStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? categories = null,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarketStateImplCopyWith<$Res>
    implements $MarketStateCopyWith<$Res> {
  factory _$$MarketStateImplCopyWith(
          _$MarketStateImpl value, $Res Function(_$MarketStateImpl) then) =
      __$$MarketStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool loading, List<String> categories});
}

/// @nodoc
class __$$MarketStateImplCopyWithImpl<$Res>
    extends _$MarketStateCopyWithImpl<$Res, _$MarketStateImpl>
    implements _$$MarketStateImplCopyWith<$Res> {
  __$$MarketStateImplCopyWithImpl(
      _$MarketStateImpl _value, $Res Function(_$MarketStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MarketState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? categories = null,
  }) {
    return _then(_$MarketStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$MarketStateImpl implements _MarketState {
  const _$MarketStateImpl(
      {this.loading = false, final List<String> categories = const []})
      : _categories = categories;

  @override
  @JsonKey()
  final bool loading;
  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  String toString() {
    return 'MarketState(loading: $loading, categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, loading, const DeepCollectionEquality().hash(_categories));

  /// Create a copy of MarketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketStateImplCopyWith<_$MarketStateImpl> get copyWith =>
      __$$MarketStateImplCopyWithImpl<_$MarketStateImpl>(this, _$identity);
}

abstract class _MarketState implements MarketState {
  const factory _MarketState(
      {final bool loading, final List<String> categories}) = _$MarketStateImpl;

  @override
  bool get loading;
  @override
  List<String> get categories;

  /// Create a copy of MarketState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketStateImplCopyWith<_$MarketStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
