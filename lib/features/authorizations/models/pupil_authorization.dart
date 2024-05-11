// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'pupil_authorization.g.dart';

@JsonSerializable()
class PupilAuthorization with _$PupilAuthorization {
  final String? comment;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'file_url')
  final String? fileUrl;
  @JsonKey(name: 'origin_authorization')
  final String originAuthorization;
  @JsonKey(name: 'pupil_id')
  final int pupilId;
  final bool? status;

  factory PupilAuthorization.fromJson(Map<String, dynamic> json) =>
      _$PupilAuthorizationFromJson(this);

  PupilAuthorization(
      {required this.comment,
      required this.createdBy,
      required this.fileUrl,
      required this.originAuthorization,
      required this.pupilId,
      required this.status});
}
