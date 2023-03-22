import 'package:freezed_annotation/freezed_annotation.dart';

part'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User{

  const factory User(
  {
    required String username,
    String? email,
    required String password,
    @JsonKey(name:'refreshToken')
    String? token,
    @JsonKey(name:'accessToken')
    String? accessToken,
  }
  ) = _User;

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
}
//flutter pub run build_runner build