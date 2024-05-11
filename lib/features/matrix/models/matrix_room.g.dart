// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatrixRoomImpl _$$MatrixRoomImplFromJson(Map<String, dynamic> json) =>
    _$MatrixRoomImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      powerLevelReactions: json['powerLevelReactions'] as int?,
      eventsDefault: json['eventsDefault'] as int?,
      roomAdmins: (json['roomAdmins'] as List<dynamic>?)
          ?.map((e) => RoomAdmin.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MatrixRoomImplToJson(_$MatrixRoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'powerLevelReactions': instance.powerLevelReactions,
      'eventsDefault': instance.eventsDefault,
      'roomAdmins': instance.roomAdmins,
    };

_$RoomAdminImpl _$$RoomAdminImplFromJson(Map<String, dynamic> json) =>
    _$RoomAdminImpl(
      id: json['id'] as String,
      powerLevel: json['powerLevel'] as int,
    );

Map<String, dynamic> _$$RoomAdminImplToJson(_$RoomAdminImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'powerLevel': instance.powerLevel,
    };
