// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
part 'missed_class.g.dart';

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
  // TODO: migrate to the new property name in the backend
  @JsonKey(name: 'returned')
  final bool? backHome;
  // TODO: migrate to the new property name in the backend
  @JsonKey(name: 'returned_at')
  final String? backHomeAt;
  @JsonKey(name: 'written_excuse')
  final bool? writtenExcuse;

  MissedClass({
    this.contacted,
    required this.createdBy,
    this.minutesLate,
    required this.excused,
    required this.missedDay,
    required this.missedPupilId,
    required this.missedType,
    this.modifiedBy,
    this.backHome,
    this.backHomeAt,
    this.writtenExcuse,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MissedClass &&
        other.contacted == contacted &&
        other.createdBy == createdBy &&
        other.excused == excused &&
        other.minutesLate == minutesLate &&
        other.missedDay == missedDay &&
        other.missedPupilId == missedPupilId &&
        other.missedType == missedType &&
        other.modifiedBy == modifiedBy &&
        other.backHome == backHome &&
        other.backHomeAt == backHomeAt &&
        other.writtenExcuse == writtenExcuse;
  }

  @override
  int get hashCode {
    return contacted.hashCode ^
        createdBy.hashCode ^
        excused.hashCode ^
        minutesLate.hashCode ^
        missedDay.hashCode ^
        missedPupilId.hashCode ^
        missedType.hashCode ^
        modifiedBy.hashCode ^
        backHome.hashCode ^
        backHomeAt.hashCode ^
        writtenExcuse.hashCode;
  }

  factory MissedClass.fromJson(Map<String, dynamic> json) =>
      _$MissedClassFromJson(json);
  Map<String, dynamic> toJson() => _$MissedClassToJson(this);
}
