// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'pupil_personal_data.g.dart';

@JsonSerializable()
class PupilPersonalData {
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
  final String? specialNeeds;
  @JsonKey(name: "gender")
  final String gender;
  @JsonKey(name: "language")
  final String language;
  @JsonKey(name: "family")
  final String? family;
  @JsonKey(name: "birthday")
  final DateTime birthday;
  @JsonKey(name: "migrationSupportEnds")
  final DateTime? migrationSupportEnds;
  @JsonKey(name: "pupilSince")
  final DateTime pupilSince;

  factory PupilPersonalData.fromJson(Map<String, dynamic> json) =>
      _$PupilPersonalDataFromJson(json);

  PupilPersonalData({
    required this.id,
    required this.name,
    required this.lastName,
    required this.group,
    required this.schoolyear,
    required this.gender,
    required this.language,
    required this.family,
    required this.birthday,
    required this.pupilSince,
    required this.specialNeeds,
    required this.migrationSupportEnds,
  });
}

@JsonSerializable()
class PupilBaseList {
  final List<PupilPersonalData> pupilBaseList;

  factory PupilBaseList.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PupilBaseListFromJson(json);

  PupilBaseList({required this.pupilBaseList});
}
