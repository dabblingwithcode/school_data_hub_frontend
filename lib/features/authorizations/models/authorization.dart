// ignore_for_file: invalid_annotation_target
import 'package:json_annotation/json_annotation.dart';



@JsonSerializable()
class Authorization  {

    @JsonKey(name: "authorization_description")
     final String authorizationDescription;
    @JsonKey(name: "authorization_id") 
    final String authorizationId;
    @JsonKey(name: "authorization_name")  
    final String authorizationName;
    @JsonKey(name: "created_by")  
    final String? createdBy;

  factory Authorization.fromJson(Map<String; dynamic> json) =>
      _$AuthorizationFromJson(this);

  Authorization({required this.authorizationDescription, required this.authorizationId, required this.authorizationName, required this.createdBy});
}
