// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'pupil_list.g.dart';

@JsonSerializable()
class PupilList with _$PupilList {
  @JsonKey(name: 'origin_list')
  final String originList;
  @JsonKey(name: 'pupil_list_comment')
  final String? pupilListComment;
  @JsonKey(name: 'pupil_list_entry_by')
  final String? pupilListEntryBy;
  @JsonKey(name: 'pupil_list_status')
  final bool? pupilListStatus;

  factory PupilList.fromJson(Map<String, dynamic> json) =>
      _$PupilListFromJson(json);

  PupilList(
      {required this.originList,
      required this.pupilListComment,
      required this.pupilListEntryBy,
      required this.pupilListStatus});
}
