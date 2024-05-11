// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatrixUserImpl _$$MatrixUserImplFromJson(Map<String, dynamic> json) =>
    _$MatrixUserImpl(
      id: json['id'] as String?,
      active: json['active'] as bool?,
      authType: json['authType'] as String?,
      displayName: json['displayName'] as String?,
      avatarUri: json['avatarUri'] as String?,
      matrixRooms: (json['joinedRoomIds'] as List<dynamic>)
          .map((e) => MatrixRoom(id: e))
          .toList(),
      forbidRoomCreation: json['forbidRoomCreation'],
      forbidEncryptedRoomCreation: json['forbidEncryptedRoomCreation'],
      forbidUnencryptedRoomCreation: json['forbidUnencryptedRoomCreation'],
      authCredential: json['authCredential'] as String?,
    );

Map<String, dynamic> _$$MatrixUserImplToJson(_$MatrixUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'authType': instance.authType,
      'displayName': instance.displayName,
      'avatarUri': instance.avatarUri,
      'joinedRoomIds': getRoomIds(instance.matrixRooms!),
      'forbidRoomCreation': instance.forbidRoomCreation,
      'forbidEncryptedRoomCreation': instance.forbidEncryptedRoomCreation,
      'forbidUnencryptedRoomCreation': instance.forbidUnencryptedRoomCreation,
      //'authCredential': instance.authCredential,
    };
getRoomIds(List<MatrixRoom> rooms) {
  return rooms.map((room) => room.id).toList();
}
