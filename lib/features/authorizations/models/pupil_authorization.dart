// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class PupilAuthorization with _$PupilAuthorization {
  factory PupilAuthorization({
    String? comment,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'file_url') String? fileUrl,
    @JsonKey(name: 'origin_authorization') required String originAuthorization,
    @JsonKey(name: 'pupil_id') required int pupilId,
    bool? status,
  }) = _Authorization;

  factory PupilAuthorization.fromJson(Map<String, dynamic> json) =>
      _$PupilAuthorizationFromJson(json);
}
