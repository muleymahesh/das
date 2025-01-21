import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "mobile")
  String? mobile;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: "region")
  String? region;
  @JsonKey(name: "supervisor_name")
  String? supervisorName;
  @JsonKey(name: "supervisor_id")
  String? supervisorId;
  @JsonKey(name: "collection")
  String? collection;
  @JsonKey(name: "commission")
  String? commission;

  UserModel({
    this.userId,
    this.name,
    this.username,
    this.mobile,
    this.password,
    this.role,
    this.region,
    this.supervisorName,
    this.supervisorId,
    this.collection,
    this.commission,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}