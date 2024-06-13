// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolList _$SchoolListFromJson(Map<String, dynamic> json) => SchoolList(
      createdBy: json['created_by'] as String,
      listDescription: json['list_description'] as String,
      listId: json['list_id'] as String,
      listName: json['list_name'] as String,
      authorizedUsers: json['authorized_users'] as String?,
      visibility: json['visibility'] as String,
      pupilLists: (json['pupils_in_list'] as List<dynamic>)
          .map((e) => PupilList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SchoolListToJson(SchoolList instance) =>
    <String, dynamic>{
      'created_by': instance.createdBy,
      'list_description': instance.listDescription,
      'list_id': instance.listId,
      'list_name': instance.listName,
      'authorized_users': instance.authorizedUsers,
      'visibility': instance.visibility,
      'pupils_in_list': instance.pupilLists,
    };
