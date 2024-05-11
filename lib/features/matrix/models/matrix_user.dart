import 'package:json_annotation/json_annotation.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';

//- After running build_runner, in matrix_user.g.dart you must do these modifications:
//- 1. in _$MatrixUserImpl ->  matrixRooms: (json['joinedRoomIds'] as List<dynamic>).map((e) => MatrixRoom(id: e)).toList(),
//- 2. in _$$MatrixUserImplToJson -> 'joinedRoomIds': getRoomIds(instance.matrixRooms!),
//- 3. add this funtion getRoomIds(List<MatrixRoom> rooms) {return rooms.map((room) => room.id).toList();}
//- 4. in _$MatrixUserImpl ->  comment out // 'authCredential': instance.authCredential,
@JsonSerializable()
class MatrixUser with _$MatrixUser {
  final String? id;
  final bool? active;
  final String? authType;
  final String? displayName;
  final String? avatarUri;
  @JsonKey(name: 'joinedRoomIds')
  final List<MatrixRoom>? matrixRooms;
  final dynamic forbidRoomCreation;
  final dynamic forbidEncryptedRoomCreation;
  final dynamic forbidUnencryptedRoomCreation;
  final String? authCredential;

  factory MatrixUser.fromJson(Map<String, dynamic> json) {
    var user = _$MatrixUserFromJson(this);
    if (user.matrixRooms != null) {
      /// eliminate duplicates
      user = user.copyWith(matrixRooms: user.matrixRooms!.toSet().toList());
    }
    return user;
  }

  MatrixUser(
      {required this.id,
      required this.active,
      required this.authType,
      required this.displayName,
      required this.avatarUri,
      required this.forbidRoomCreation,
      required this.forbidEncryptedRoomCreation,
      required this.forbidUnencryptedRoomCreation,
      required this.authCredential});
}
