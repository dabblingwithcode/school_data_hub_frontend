// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pupil_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PupilList _$PupilListFromJson(Map<String, dynamic> json) => PupilList(
      listedPupilId: (json['listed_pupil_id'] as num).toInt(),
      originList: json['origin_list'] as String,
      pupilListComment: json['pupil_list_comment'] as String?,
      pupilListEntryBy: json['pupil_list_entry_by'] as String?,
      pupilListStatus: json['pupil_list_status'] as bool?,
    );

Map<String, dynamic> _$PupilListToJson(PupilList instance) => <String, dynamic>{
      'listed_pupil_id': instance.listedPupilId,
      'origin_list': instance.originList,
      'pupil_list_comment': instance.pupilListComment,
      'pupil_list_entry_by': instance.pupilListEntryBy,
      'pupil_list_status': instance.pupilListStatus,
    };
