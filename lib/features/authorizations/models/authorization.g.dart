// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthorizationImpl _$$AuthorizationImplFromJson(Map<String, dynamic> json) =>
    _$AuthorizationImpl(
      authorizationDescription: json['authorization_description'] as String,
      authorizationId: json['authorization_id'] as String,
      authorizationName: json['authorization_name'] as String,
      createdBy: json['created_by'] as String?,
    );

Map<String, dynamic> _$$AuthorizationImplToJson(_$AuthorizationImpl instance) =>
    <String, dynamic>{
      'authorization_description': instance.authorizationDescription,
      'authorization_id': instance.authorizationId,
      'authorization_name': instance.authorizationName,
      'created_by': instance.createdBy,
    };
