import 'package:freezed_annotation/freezed_annotation.dart';

part 'schoolday.freezed.dart';
part 'schoolday.g.dart';

@freezed
class Schoolday with _$Schoolday {
  factory Schoolday({
    required DateTime schoolday,
  }) = _Schoolday;

  factory Schoolday.fromJson(Map<String, dynamic> json) =>
      _$SchooldayFromJson(json);
}
