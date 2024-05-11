// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
part 'pupil_base.g.dart';

@JsonSerializable()
class PupilBase with _$PupilBase {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "lastName")
  final String lastName;
  @JsonKey(name: "group")
  final String group;
  @JsonKey(name: "schoolyear")
  final String schoolyear;
  @JsonKey(name: "specialNeeds")
  String? specialNeeds;
  @JsonKey(name: "gender")
  final String gender;
  @JsonKey(name: "language")
  final String language;
  @JsonKey(name: "family")
  final String? family;
  @JsonKey(name: "birthday")
  final DateTime birthday;
  @JsonKey(name: "migrationSupportEnds")
  DateTime? migrationSupportEnds;
  @JsonKey(name: "pupilSince")
  final DateTime pupilSince;

  factory PupilBase.fromJson(Map<String, dynamic> json) =>
      _$PupilBaseFromJson(json);

  PupilBase(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.group,
      required this.schoolyear,
      required this.gender,
      required this.language,
      required this.family,
      required this.birthday,
      required this.pupilSince});
}

@JsonSerializable()
abstract class PupilBaseList with _$PupilBaseList {
  final List<PupilBase> pupilBaseList;

  factory PupilBaseList.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PupilBaseListFromJson(this);

  PupilBaseList({required this.pupilBaseList});
}
