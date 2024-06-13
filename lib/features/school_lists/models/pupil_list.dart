// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'pupil_list.g.dart';

@JsonSerializable()
class PupilList {
  @JsonKey(name: 'listed_pupil_id')
  final int listedPupilId;
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

  Map<String, dynamic> toJson() => _$PupilListToJson(this);

  PupilList(
      {required this.listedPupilId,
      required this.originList,
      required this.pupilListComment,
      required this.pupilListEntryBy,
      required this.pupilListStatus});
}
