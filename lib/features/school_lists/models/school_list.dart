// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
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

  factory SchoolList.fromJson(Map<String, dynamic> json) =>
      _$SchoolListFromJson(json);

  SchoolList(
      {required this.createdBy,
      required this.listDescription,
      required this.listId,
      required this.listName,
      required this.authorizedUsers,
      required this.visibility});
}
