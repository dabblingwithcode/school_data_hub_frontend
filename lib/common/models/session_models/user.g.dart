// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      admin: json['admin'] as bool,
      publicId: json['public_id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      tutoring: json['tutoring'] as String?,
      credit: json['credit'] as int,
      timeUnits: json['time_units'] as int,
      contact: json['contact'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'admin': instance.admin,
      'public_id': instance.publicId,
      'name': instance.name,
      'role': instance.role,
      'tutoring': instance.tutoring,
      'credit': instance.credit,
      'time_units': instance.timeUnits,
      'contact': instance.contact,
    };
