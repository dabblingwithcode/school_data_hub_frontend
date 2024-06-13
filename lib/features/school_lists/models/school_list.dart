// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
part 'school_list.g.dart';

@JsonSerializable()
class SchoolList {
  @JsonKey(name: 'created_by')
  final String createdBy;
  @JsonKey(name: 'list_description')
  final String listDescription;
  @JsonKey(name: 'list_id')
  final String listId;
  @JsonKey(name: 'list_name')
  final String listName;
  @JsonKey(name: 'authorized_users')
  String? authorizedUsers;
  final String visibility;
  @JsonKey(name: 'pupils_in_list')
  final List<PupilList> pupilLists;

  factory SchoolList.fromJson(Map<String, dynamic> json) =>
      _$SchoolListFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolListToJson(this);

  SchoolList({
    required this.createdBy,
    required this.listDescription,
    required this.listId,
    required this.listName,
    required this.authorizedUsers,
    required this.visibility,
    required this.pupilLists,
  });
}
