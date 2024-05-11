// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';

import 'flags.dart';
import 'matrix_user.dart';

part 'policy.freezed.dart';
part 'policy.g.dart';

//- After running build_runner, in policy.g.dart you must do these modifications:
//- 1. in _$$PolicyImplFromJson ->  matrixRooms: (json['managedRoomIds'] as List<dynamic>).map((e) => MatrixRoom(id: e)).toList(),
//- 2. in _$$PolicyImplToJson -> 'managedRoomIds': getRoomIds(instance.matrixRooms!),
//- 3. add this funtion getRoomIds(List<MatrixRoom> rooms) {return rooms.map((room) => room.id).toList();}

@freezed
class Policy with _$Policy {
  factory Policy({
    int? schemaVersion,
    dynamic identificationStamp,
    Flags? flags,
    dynamic hooks,
    @JsonKey(name: 'managedRoomIds') List<MatrixRoom>? matrixRooms,
    @JsonKey(name: 'users') List<MatrixUser>? matrixUsers,
  }) = _Policy;

  factory Policy.fromJson(Map<String, dynamic> json) => _$PolicyFromJson(json);
}
