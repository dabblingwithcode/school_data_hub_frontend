// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';

import 'flags.dart';
import 'matrix_user.dart';

//- After running build_runner, in policy.g.dart you must do these modifications:
//- 1. in _$$PolicyImplFromJson ->  matrixRooms: (json['managedRoomIds'] as List<dynamic>).map((e) => MatrixRoom(id: e)).toList(),
//- 2. in _$$PolicyImplToJson -> 'managedRoomIds': getRoomIds(instance.matrixRooms!),
//- 3. add this funtion getRoomIds(List<MatrixRoom> rooms) {return rooms.map((room) => room.id).toList();}

@JsonSerializable()
class Policy {
  final int? schemaVersion;
  final dynamic identificationStamp;
  final Flags? flags;
  final dynamic hooks;
  @JsonKey(name: 'managedRoomIds')
  final List<MatrixRoom>? matrixRooms;
  @JsonKey(name: 'users')
  final List<MatrixUser>? matrixUsers;

  factory Policy.fromJson(Map<String, dynamic> json) => _$PolicyFromJson(json);

  Policy(
      {required this.schemaVersion,
      required this.identificationStamp,
      required this.flags,
      required this.hooks,
      required this.matrixRooms,
      required this.matrixUsers});
}
