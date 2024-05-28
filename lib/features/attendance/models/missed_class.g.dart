// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'missed_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissedClass _$MissedClassFromJson(Map<String, dynamic> json) => MissedClass(
      contacted: json['contacted'] as String?,
      createdBy: json['created_by'] as String,
      minutesLate: json['minutes_late'] as int?,
      excused: json['excused'] as bool?,
      missedDay: DateTime.parse(json['missed_day'] as String),
      missedPupilId: json['missed_pupil_id'] as int,
      missedType: json['missed_type'] as String,
      modifiedBy: json['modified_by'] as String?,
      returned: json['returned'] as bool?,
      returnedAt: json['returned_at'] as String?,
      writtenExcuse: json['written_excuse'] as bool?,
    );

Map<String, dynamic> _$MissedClassToJson(MissedClass instance) =>
    <String, dynamic>{
      'contacted': instance.contacted,
      'created_by': instance.createdBy,
      'excused': instance.excused,
      'minutes_late': instance.minutesLate,
      'missed_day': instance.missedDay.toIso8601String(),
      'missed_pupil_id': instance.missedPupilId,
      'missed_type': instance.missedType,
      'modified_by': instance.modifiedBy,
      'returned': instance.returned,
      'returned_at': instance.returnedAt,
      'written_excuse': instance.writtenExcuse,
    };
