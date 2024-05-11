import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';

part 'matrix_user.freezed.dart';
part 'matrix_user.g.dart';

//- After running build_runner, in matrix_user.g.dart you must do these modifications:
//- 1. in _$MatrixUserImpl ->  matrixRooms: (json['joinedRoomIds'] as List<dynamic>).map((e) => MatrixRoom(id: e)).toList(),
//- 2. in _$$MatrixUserImplToJson -> 'joinedRoomIds': getRoomIds(instance.matrixRooms!),
//- 3. add this funtion getRoomIds(List<MatrixRoom> rooms) {return rooms.map((room) => room.id).toList();}
//- 4. in _$MatrixUserImpl ->  comment out // 'authCredential': instance.authCredential,
@freezed
class MatrixUser with _$MatrixUser {
  factory MatrixUser({
    String? id,
    bool? active,
    String? authType,
    String? displayName,
    String? avatarUri,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'joinedRoomIds') List<MatrixRoom>? matrixRooms,
    dynamic forbidRoomCreation,
    dynamic forbidEncryptedRoomCreation,
    dynamic forbidUnencryptedRoomCreation,
    String? authCredential,
  }) = _MatrixUser;

  factory MatrixUser.fromJson(Map<String, dynamic> json) {
    var user = _$MatrixUserFromJson(json);
    if (user.matrixRooms != null) {
      user = user.copyWith(matrixRooms: user.matrixRooms!.toSet().toList());
    }
    return user;
  }
  // factory MatrixUser.fromJson(Map<String, dynamic> json) =>
  //     _$MatrixUserFromJson(json);
}
