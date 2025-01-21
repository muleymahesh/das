import 'package:das_app/data/model/UserModel.dart';
import 'package:json_annotation/json_annotation.dart';

/// message : "Login successful"
/// user : {"user_id":"5","name":"Mahesh\nMuley","username":"muley.mahesh@gmail.com","mobile":"9890473764","password":"mahesh","role":"Field\nOfficer","region":"west Maharashtra","supervisor_name":"Jane Smith","collection":"0.00","commission":"0.00"}
part 'LoginResponse.g.dart';
@JsonSerializable()
class LoginResponse {

  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "user")
  UserModel? user;
@JsonKey(name: "error")
  String? error;

  LoginResponse({
      required this.message,
      required this.user,required this.error});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

