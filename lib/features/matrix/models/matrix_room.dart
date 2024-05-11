import 'package:json_annotation/json_annotation.dart';

part 'matrix_room.freezed.dart';
part 'matrix_room.g.dart';

@JsonSerializable()
class MatrixRoom with _$MatrixRoom {
  factory MatrixRoom.fromPolicyId(String policyId) {
    // Extract id from the string
    final parts = policyId.split(":");
    final id = parts.first;
    return MatrixRoom(
        id: id,
        name: null,
        powerLevelReactions: null,
        eventsDefault: null,
        roomAdmins: null);
  }
  factory MatrixRoom({
    required String id,
    String? name,
    int? powerLevelReactions,
    int? eventsDefault,
    List<RoomAdmin>? roomAdmins, // Optional name field
  }) = _MatrixRoom;

  factory MatrixRoom.fromJson(Map<String, dynamic> json) =>
      _$MatrixRoomFromJson(json);
  const MatrixRoom._();
}

@JsonSerializable()
class RoomAdmin with _$RoomAdmin {
  factory RoomAdmin({required String id, required int powerLevel}) = _RoomAdmin;

  factory RoomAdmin.fromJson(Map<String, dynamic> json) =>
      _$RoomAdminFromJson(json);
}

// from json method

