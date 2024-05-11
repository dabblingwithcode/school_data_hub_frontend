// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MissedClass {
  final String? contacted;
  @JsonKey(name: 'created_by')
  final String createdBy;
  bool? excused;
  @JsonKey(name: 'minutes_late')
  int? minutesLate;
  @JsonKey(name: 'missed_day')
  final DateTime missedDay;
  @JsonKey(name: 'missed_pupil_id')
  final int missedPupilId;
  @JsonKey(name: 'missed_type')
  final String missedType;
  @JsonKey(name: 'modified_by')
  final String? modifiedBy;
  final bool? returned;
  @JsonKey(name: 'returned_at')
  final String? returnedAt;
  @JsonKey(name: 'written_excuse')
  final bool? writtenExcuse;

  MissedClass(
      {required this.contacted,
      required this.createdBy,
      required this.missedDay,
      required this.missedPupilId,
      required this.missedType,
      required this.modifiedBy,
      required this.returned,
      required this.returnedAt,
      required this.writtenExcuse});

  factory MissedClass.fromJson(Map<String, dynamic> json) =>
      _$MissedClassFromJson(json);
}
