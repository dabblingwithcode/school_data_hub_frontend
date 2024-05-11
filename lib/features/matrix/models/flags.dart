import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Flags with _$Flags {
  final bool? allowCustomUserDisplayNames;
  final bool? allowCustomUserAvatars;
  final bool? allowCustomPassthroughUserPasswords;
  final bool? allowUnauthenticatedPasswordResets;
  final bool? forbidRoomCreation;
  final bool? forbidEncryptedRoomCreation;
  final bool? forbidUnencryptedRoomCreation;
  final bool? allow3pidLogin;

  factory Flags.fromJson(Map<String, dynamic> json) => _$FlagsFromJson(json);

  Flags(
      {required this.allowCustomUserDisplayNames,
      required this.allowCustomUserAvatars,
      required this.allowCustomPassthroughUserPasswords,
      required this.allowUnauthenticatedPasswordResets,
      required this.forbidRoomCreation,
      required this.forbidEncryptedRoomCreation,
      required this.forbidUnencryptedRoomCreation,
      required this.allow3pidLogin});
}
