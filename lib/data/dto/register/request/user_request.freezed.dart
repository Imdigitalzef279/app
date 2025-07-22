// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) {
  return _UserRequest.fromJson(json);
}

/// @nodoc
mixin _$UserRequest {
  @JsonKey(name: 'userName')
  String get userName => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'surname')
  String get surname => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'phoneNumber')
  String get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'isActive')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'lockoutEnabled')
  bool get lockoutEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'roleNames')
  List<String> get roleNames => throw _privateConstructorUsedError;
  @JsonKey(name: 'password')
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'extraProperties')
  ExtraProperties get extraProperties => throw _privateConstructorUsedError;

  /// Serializes this UserRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserRequestCopyWith<UserRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRequestCopyWith<$Res> {
  factory $UserRequestCopyWith(
          UserRequest value, $Res Function(UserRequest) then) =
      _$UserRequestCopyWithImpl<$Res, UserRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'userName') String userName,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'surname') String surname,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'phoneNumber') String phoneNumber,
      @JsonKey(name: 'isActive') bool isActive,
      @JsonKey(name: 'lockoutEnabled') bool lockoutEnabled,
      @JsonKey(name: 'roleNames') List<String> roleNames,
      @JsonKey(name: 'password') String password,
      @JsonKey(name: 'extraProperties') ExtraProperties extraProperties});

  $ExtraPropertiesCopyWith<$Res> get extraProperties;
}

/// @nodoc
class _$UserRequestCopyWithImpl<$Res, $Val extends UserRequest>
    implements $UserRequestCopyWith<$Res> {
  _$UserRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? name = null,
    Object? surname = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? isActive = null,
    Object? lockoutEnabled = null,
    Object? roleNames = null,
    Object? password = null,
    Object? extraProperties = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lockoutEnabled: null == lockoutEnabled
          ? _value.lockoutEnabled
          : lockoutEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      roleNames: null == roleNames
          ? _value.roleNames
          : roleNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      extraProperties: null == extraProperties
          ? _value.extraProperties
          : extraProperties // ignore: cast_nullable_to_non_nullable
              as ExtraProperties,
    ) as $Val);
  }

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExtraPropertiesCopyWith<$Res> get extraProperties {
    return $ExtraPropertiesCopyWith<$Res>(_value.extraProperties, (value) {
      return _then(_value.copyWith(extraProperties: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserRequestImplCopyWith<$Res>
    implements $UserRequestCopyWith<$Res> {
  factory _$$UserRequestImplCopyWith(
          _$UserRequestImpl value, $Res Function(_$UserRequestImpl) then) =
      __$$UserRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'userName') String userName,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'surname') String surname,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'phoneNumber') String phoneNumber,
      @JsonKey(name: 'isActive') bool isActive,
      @JsonKey(name: 'lockoutEnabled') bool lockoutEnabled,
      @JsonKey(name: 'roleNames') List<String> roleNames,
      @JsonKey(name: 'password') String password,
      @JsonKey(name: 'extraProperties') ExtraProperties extraProperties});

  @override
  $ExtraPropertiesCopyWith<$Res> get extraProperties;
}

/// @nodoc
class __$$UserRequestImplCopyWithImpl<$Res>
    extends _$UserRequestCopyWithImpl<$Res, _$UserRequestImpl>
    implements _$$UserRequestImplCopyWith<$Res> {
  __$$UserRequestImplCopyWithImpl(
      _$UserRequestImpl _value, $Res Function(_$UserRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? name = null,
    Object? surname = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? isActive = null,
    Object? lockoutEnabled = null,
    Object? roleNames = null,
    Object? password = null,
    Object? extraProperties = null,
  }) {
    return _then(_$UserRequestImpl(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lockoutEnabled: null == lockoutEnabled
          ? _value.lockoutEnabled
          : lockoutEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      roleNames: null == roleNames
          ? _value._roleNames
          : roleNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      extraProperties: null == extraProperties
          ? _value.extraProperties
          : extraProperties // ignore: cast_nullable_to_non_nullable
              as ExtraProperties,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserRequestImpl implements _UserRequest {
  const _$UserRequestImpl(
      {@JsonKey(name: 'userName') this.userName = "",
      @JsonKey(name: 'name') this.name = "",
      @JsonKey(name: 'surname') this.surname = "",
      @JsonKey(name: 'email') this.email = "",
      @JsonKey(name: 'phoneNumber') this.phoneNumber = "0985629282",
      @JsonKey(name: 'isActive') this.isActive = true,
      @JsonKey(name: 'lockoutEnabled') this.lockoutEnabled = true,
      @JsonKey(name: 'roleNames') final List<String> roleNames = const ["USER"],
      @JsonKey(name: 'password') this.password = "",
      @JsonKey(name: 'extraProperties')
      this.extraProperties = const ExtraProperties(projectId: 21)})
      : _roleNames = roleNames;

  factory _$UserRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserRequestImplFromJson(json);

  @override
  @JsonKey(name: 'userName')
  final String userName;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'surname')
  final String surname;
  @override
  @JsonKey(name: 'email')
  final String email;
  @override
  @JsonKey(name: 'phoneNumber')
  final String phoneNumber;
  @override
  @JsonKey(name: 'isActive')
  final bool isActive;
  @override
  @JsonKey(name: 'lockoutEnabled')
  final bool lockoutEnabled;
  final List<String> _roleNames;
  @override
  @JsonKey(name: 'roleNames')
  List<String> get roleNames {
    if (_roleNames is EqualUnmodifiableListView) return _roleNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roleNames);
  }

  @override
  @JsonKey(name: 'password')
  final String password;
  @override
  @JsonKey(name: 'extraProperties')
  final ExtraProperties extraProperties;

  @override
  String toString() {
    return 'UserRequest(userName: $userName, name: $name, surname: $surname, email: $email, phoneNumber: $phoneNumber, isActive: $isActive, lockoutEnabled: $lockoutEnabled, roleNames: $roleNames, password: $password, extraProperties: $extraProperties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRequestImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.lockoutEnabled, lockoutEnabled) ||
                other.lockoutEnabled == lockoutEnabled) &&
            const DeepCollectionEquality()
                .equals(other._roleNames, _roleNames) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.extraProperties, extraProperties) ||
                other.extraProperties == extraProperties));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userName,
      name,
      surname,
      email,
      phoneNumber,
      isActive,
      lockoutEnabled,
      const DeepCollectionEquality().hash(_roleNames),
      password,
      extraProperties);

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRequestImplCopyWith<_$UserRequestImpl> get copyWith =>
      __$$UserRequestImplCopyWithImpl<_$UserRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserRequestImplToJson(
      this,
    );
  }
}

abstract class _UserRequest implements UserRequest {
  const factory _UserRequest(
      {@JsonKey(name: 'userName') final String userName,
      @JsonKey(name: 'name') final String name,
      @JsonKey(name: 'surname') final String surname,
      @JsonKey(name: 'email') final String email,
      @JsonKey(name: 'phoneNumber') final String phoneNumber,
      @JsonKey(name: 'isActive') final bool isActive,
      @JsonKey(name: 'lockoutEnabled') final bool lockoutEnabled,
      @JsonKey(name: 'roleNames') final List<String> roleNames,
      @JsonKey(name: 'password') final String password,
      @JsonKey(name: 'extraProperties')
      final ExtraProperties extraProperties}) = _$UserRequestImpl;

  factory _UserRequest.fromJson(Map<String, dynamic> json) =
      _$UserRequestImpl.fromJson;

  @override
  @JsonKey(name: 'userName')
  String get userName;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'surname')
  String get surname;
  @override
  @JsonKey(name: 'email')
  String get email;
  @override
  @JsonKey(name: 'phoneNumber')
  String get phoneNumber;
  @override
  @JsonKey(name: 'isActive')
  bool get isActive;
  @override
  @JsonKey(name: 'lockoutEnabled')
  bool get lockoutEnabled;
  @override
  @JsonKey(name: 'roleNames')
  List<String> get roleNames;
  @override
  @JsonKey(name: 'password')
  String get password;
  @override
  @JsonKey(name: 'extraProperties')
  ExtraProperties get extraProperties;

  /// Create a copy of UserRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRequestImplCopyWith<_$UserRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
