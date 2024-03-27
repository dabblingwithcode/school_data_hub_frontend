// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pupil_authorization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthorizationImpl _$$AuthorizationImplFromJson(Map<String, dynamic> json) =>
    _$AuthorizationImpl(
      comment: json['comment'] as String?,
      createdBy: json['created_by'] as String?,
      fileUrl: json['file_url'] as String?,
      originAuthorization: json['origin_authorization'] as String,
      pupilId: json['pupil_id'] as int,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$$AuthorizationImplToJson(_$AuthorizationImpl instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'created_by': instance.createdBy,
      'file_url': instance.fileUrl,
      'origin_authorization': instance.originAuthorization,
      'pupil_id': instance.pupilId,
      'status': instance.status,
    };
