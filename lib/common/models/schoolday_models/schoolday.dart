import 'package:json_annotation/json_annotation.dart';

part 'schoolday.g.dart';

@JsonSerializable()
class Schoolday {
  final DateTime schoolday;

  factory Schoolday.fromJson(Map<String, dynamic> json) =>
      _$SchooldayFromJson(json);

  Map<String, dynamic> toJson() => _$SchooldayToJson(this);
  Schoolday({required this.schoolday});
}

@JsonSerializable()
class SchoolSemester {
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @JsonKey(name: 'end_date')
  final DateTime endDate;
  @JsonKey(name: 'is_first')
  final bool isFirst;

  factory SchoolSemester.fromJson(Map<String, dynamic> json) =>
      _$SchoolSemesterFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolSemesterToJson(this);
  SchoolSemester(
      {required this.startDate, required this.endDate, required this.isFirst});
}
