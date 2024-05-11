import 'package:json_annotation/json_annotation.dart';

part 'schoolday.freezed.dart';
part 'schoolday.g.dart';

@JsonSerializable()
class Schoolday with _$Schoolday {
  factory Schoolday({
    required DateTime schoolday,
  }) = _Schoolday;

  factory Schoolday.fromJson(Map<String, dynamic> json) =>
      _$SchooldayFromJson(json);
}
