// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'missed_class.freezed.dart';
part 'missed_class.g.dart';

@JsonSerializable()
class MissedClass with _$MissedClass {
  factory MissedClass({
    String? contacted,
    @JsonKey(name: 'created_by') required String createdBy,
    bool? excused,
    @JsonKey(name: 'minutes_late') int? minutesLate,
    @JsonKey(name: 'missed_day') required DateTime missedDay,
    @JsonKey(name: 'missed_pupil_id') required int missedPupilId,
    @JsonKey(name: 'missed_type') required String missedType,
    @JsonKey(name: 'modified_by') String? modifiedBy,
    bool? returned,
    @JsonKey(name: 'returned_at') String? returnedAt,
    @JsonKey(name: 'written_excuse') bool? writtenExcuse,
  }) = _MissedClass;

  factory MissedClass.fromJson(Map<String, dynamic> json) =>
      _$MissedClassFromJson(json);
}
