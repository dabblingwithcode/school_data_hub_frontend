// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SchoolListImpl _$$SchoolListImplFromJson(Map<String, dynamic> json) =>
    _$SchoolListImpl(
      createdBy: json['created_by'] as String,
      listDescription: json['list_description'] as String,
      listId: json['list_id'] as String,
      listName: json['list_name'] as String,
      visibility: json['visibility'] as String,
    );

Map<String, dynamic> _$$SchoolListImplToJson(_$SchoolListImpl instance) =>
    <String, dynamic>{
      'created_by': instance.createdBy,
      'list_description': instance.listDescription,
      'list_id': instance.listId,
      'list_name': instance.listName,
      'visibility': instance.visibility,
    };
