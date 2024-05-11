// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatrixUser _$MatrixUserFromJson(Map<String, dynamic> json) => MatrixUser(
      id: json['id'] as String?,
      displayName: json['displayName'] as String?,
      joinedRoomIds: (json['joinedRoomIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MatrixUserToJson(MatrixUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'joinedRoomIds': instance.joinedRoomIds,
    };
