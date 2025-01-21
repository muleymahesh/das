// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['user_id'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      mobile: json['mobile'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      region: json['region'] as String?,
      supervisorName: json['supervisor_name'] as String?,
      supervisorId: json['supervisor_id'] as String?,
      collection: json['collection'] as String?,
      commission: json['commission'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'username': instance.username,
      'mobile': instance.mobile,
      'password': instance.password,
      'role': instance.role,
      'region': instance.region,
      'supervisor_name': instance.supervisorName,
      'supervisor_id': instance.supervisorId,
      'collection': instance.collection,
      'commission': instance.commission,
    };
