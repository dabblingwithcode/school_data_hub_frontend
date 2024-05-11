import 'package:json_annotation/json_annotation.dart';

part 'schoolday.g.dart';

@JsonSerializable()
class Schoolday {
  final DateTime schoolday;

  factory Schoolday.fromJson(Map<String, dynamic> json) =>
      _$SchooldayFromJson(json);

  Schoolday({required this.schoolday});
}
