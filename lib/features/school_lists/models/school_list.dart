// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'school_list.freezed.dart';
part 'school_list.g.dart';

@JsonSerializable()
class SchoolList with _$SchoolList {
  factory SchoolList({
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'list_description') required String listDescription,
    @JsonKey(name: 'list_id') required String listId,
    @JsonKey(name: 'list_name') required String listName,
    @JsonKey(name: 'authorized_users') String? authorizedUsers,
    required String visibility,
  }) = _SchoolList;

  factory SchoolList.fromJson(Map<String, dynamic> json) =>
      _$SchoolListFromJson(json);
}
