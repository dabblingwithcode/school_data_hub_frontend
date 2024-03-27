// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String?,
      active: json['active'] as bool?,
      authType: json['authType'] as String?,
      displayName: json['displayName'] as String?,
      avatarUri: json['avatarUri'] as String?,
      joinedRoomIds: (json['joinedRoomIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      forbidRoomCreation: json['forbidRoomCreation'],
      forbidEncryptedRoomCreation: json['forbidEncryptedRoomCreation'],
      forbidUnencryptedRoomCreation: json['forbidUnencryptedRoomCreation'],
      authCredential: json['authCredential'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'authType': instance.authType,
      'displayName': instance.displayName,
      'avatarUri': instance.avatarUri,
      'joinedRoomIds': instance.joinedRoomIds,
      'forbidRoomCreation': instance.forbidRoomCreation,
      'forbidEncryptedRoomCreation': instance.forbidEncryptedRoomCreation,
      'forbidUnencryptedRoomCreation': instance.forbidUnencryptedRoomCreation,
      'authCredential': instance.authCredential,
    };
