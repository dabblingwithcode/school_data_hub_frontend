import 'package:json_annotation/json_annotation.dart';
part 'matrix_room.g.dart';

class MatrixRoom {
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
  final String id;
  String? name;
  int? powerLevelReactions;
  int? eventsDefault;
  List<RoomAdmin>? roomAdmins; // Optional name field

  MatrixRoom(
      {required this.id,
      this.name,
      this.powerLevelReactions,
      this.eventsDefault,
      this.roomAdmins});
}

@JsonSerializable()
class RoomAdmin {
  final String id;
  final int powerLevel;

  factory RoomAdmin.fromJson(Map<String, dynamic> json) =>
      _$RoomAdminFromJson(json);

  Map<String, dynamic> toJson() => _$RoomAdminToJson(this);

  RoomAdmin({required this.id, required this.powerLevel});
}

// from json method

