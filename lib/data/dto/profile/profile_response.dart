import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_response.freezed.dart';

part 'profile_response.g.dart';

@freezed
class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    @JsonKey(name: 'userName') @Default("") String userName,
    @JsonKey(name: 'email') @Default("") String email,
    @JsonKey(name: 'name') @Default("") String name,
    @JsonKey(name: 'surname') @Default("") String surname,
    @JsonKey(name: 'phoneNumber') @Default("") String phoneNumber,
    @JsonKey(name: 'avatar') @Default("") String avatar,
    @JsonKey(name: 'gender') @Default("") String gender,
    @JsonKey(name: 'birthday') @Default("") String birthday,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}