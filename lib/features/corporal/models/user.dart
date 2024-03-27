import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    String? id,
    bool? active,
    String? authType,
    String? displayName,
    String? avatarUri,
    List<String>? joinedRoomIds,
    dynamic forbidRoomCreation,
    dynamic forbidEncryptedRoomCreation,
    dynamic forbidUnencryptedRoomCreation,
    String? authCredential,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
