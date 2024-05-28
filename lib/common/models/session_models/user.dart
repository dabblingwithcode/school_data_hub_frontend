import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final bool admin;
  @JsonKey(name: 'public_id')
  final String publicId;
  final String name;
  final String role;
  final String? tutoring;
  final int credit;
  @JsonKey(name: 'time_units')
  final int timeUnits;
  final String? contact;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User({
    required this.admin,
    required this.publicId,
    required this.name,
    required this.role,
    this.tutoring,
    required this.credit,
    required this.timeUnits,
    this.contact,
  });

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
