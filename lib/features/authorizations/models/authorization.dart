// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authorization.freezed.dart';
part 'authorization.g.dart';

@freezed
class Authorization with _$Authorization {
  const factory Authorization({
    @JsonKey(name: "authorization_description")
    required String authorizationDescription,
    @JsonKey(name: "authorization_id") required String authorizationId,
    @JsonKey(name: "authorization_name") required String authorizationName,
    @JsonKey(name: "created_by") required String? createdBy,
  }) = _Authorization;

  factory Authorization.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationFromJson(json);
}
