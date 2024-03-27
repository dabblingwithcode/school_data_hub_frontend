// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pupil_base.freezed.dart';
part 'pupil_base.g.dart';

@freezed
class PupilBase with _$PupilBase {
  const factory PupilBase({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "lastName") required String lastName,
    @JsonKey(name: "group") required String group,
    @JsonKey(name: "schoolyear") required String schoolyear,
    @JsonKey(name: "specialNeeds") String? specialNeeds,
    @JsonKey(name: "gender") required String gender,
    @JsonKey(name: "language") required String language,
    @JsonKey(name: "family") String? family,
    @JsonKey(name: "birthday") required DateTime birthday,
    @JsonKey(name: "migrationSupportEnds") DateTime? migrationSupportEnds,
    @JsonKey(name: "pupilSince") required DateTime pupilSince,
  }) = _PupilBase;

  factory PupilBase.fromJson(Map<String, dynamic> json) =>
      _$PupilBaseFromJson(json);
}

@freezed
abstract class PupilBaseList with _$PupilBaseList {
  const factory PupilBaseList({
    required List<PupilBase> pupilBaseList,
  }) = _PupilBaseList;
  factory PupilBaseList.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PupilBaseListFromJson(json);
}
