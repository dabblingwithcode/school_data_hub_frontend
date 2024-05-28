import 'package:json_annotation/json_annotation.dart';
import 'package:schuldaten_hub/features/matrix/models/matrix_room.dart';

part 'matrix_user.g.dart';

//- After running build_runner, in matrix_user.g.dart you must do these modifications:
//- 1. in _$MatrixUserImpl ->  matrixRooms: (json['joinedRoomIds'] as List<dynamic>).map((e) => MatrixRoom(id: e)).toList(),
//- 2. in _$$MatrixUserImplToJson -> 'joinedRoomIds': getRoomIds(instance.matrixRooms!),
//- 3. add this funtion getRoomIds(List<MatrixRoom> rooms) {return rooms.map((room) => room.id).toList();}
//- 4. in _$MatrixUserImpl ->  comment out // 'authCredential': instance.authCredential,
@JsonSerializable()
class MatrixUser {
  final String? id;
  // we don't use this fields
  final bool? active;
  final String? authType;
  final String displayName;
  // final String? avatarUri;
  List<String> joinedRoomIds;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<MatrixRoom> matrixRooms = [];
  // final bool forbidRoomCreation;
  // final bool forbidEncryptedRoomCreation;
  // final bool forbidUnencryptedRoomCreation;
  // final String? authCredential;

  factory MatrixUser.fromJson(Map<String, dynamic> json) {
    var user = _$MatrixUserFromJson(json);
    if (user.joinedRoomIds.isNotEmpty) {
      /// eliminate duplicates
      user.joinedRoomIds = user.joinedRoomIds.toSet().toList();
      for (var roomId in user.joinedRoomIds) {
        user.matrixRooms.add(MatrixRoom(id: roomId));
      }
    }
    return user;
  }

  Map<String, dynamic> toJson() {
    var json = _$MatrixUserToJson(this);
    json['joinedRoomIds'] = joinedRoomIds;
    return json;
  }

  void joinRoom(MatrixRoom room) {
    matrixRooms.add(room);
    joinedRoomIds.add(room.id);
  }

  MatrixUser(
      {required this.id,
      this.active,
      this.authType,
      required this.displayName,
      // required this.avatarUri,
      // required this.forbidRoomCreation,
      // required this.forbidEncryptedRoomCreation,
      // required this.forbidUnencryptedRoomCreation,
      // required this.authCredential,
      this.joinedRoomIds = const []});
}
