
part of 'account_cubit.dart';

@freezed
class AccountState with _$AccountState {
  const factory AccountState(
      {
        required Result<ProfileResponse> request,
        @Default("") String error,
        @Default("") String userName,
        @Default("") String name,
        @Default("") String surname,
        @Default("") String email,
        @Default("") String phoneNumber,
      }) = _AccountState;

  factory AccountState.initial() => AccountState(request: Result(data: const ProfileResponse()));
}
