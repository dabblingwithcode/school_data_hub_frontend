// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'pupil_list.freezed.dart';
part 'pupil_list.g.dart';

@JsonSerializable()
class PupilList with _$PupilList {
  factory PupilList({
    @JsonKey(name: 'origin_list') required String originList,
    @JsonKey(name: 'pupil_list_comment') String? pupilListComment,
    @JsonKey(name: 'pupil_list_entry_by') String? pupilListEntryBy,
    @JsonKey(name: 'pupil_list_status') bool? pupilListStatus,
  }) = _PupilList;

  factory PupilList.fromJson(Map<String, dynamic> json) =>
      _$PupilListFromJson(json);
}
