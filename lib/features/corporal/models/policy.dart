import 'package:freezed_annotation/freezed_annotation.dart';

import 'flags.dart';
import 'user.dart';

part 'policy.freezed.dart';
part 'policy.g.dart';

@freezed
class Policy with _$Policy {
  factory Policy({
    int? schemaVersion,
    dynamic identificationStamp,
    Flags? flags,
    dynamic hooks,
    List<String>? managedRoomIds,
    List<User>? users,
  }) = _Policy;

  factory Policy.fromJson(Map<String, dynamic> json) => _$PolicyFromJson(json);
}
