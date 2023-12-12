// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminRequestModel _$AdminRequestModelFromJson(Map<String, dynamic> json) =>
    AdminRequestModel(
      name: json['name'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      departmentName: json['departmentName'] as String,
    );

Map<String, dynamic> _$AdminRequestModelToJson(AdminRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'username': instance.username,
      'password': instance.password,
      'role': instance.role,
      'departmentName': instance.departmentName,
    };
