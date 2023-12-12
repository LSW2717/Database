// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminResponseModel _$AdminResponseModelFromJson(Map<String, dynamic> json) =>
    AdminResponseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      departmentName: json['departmentName'] as String,
    );

Map<String, dynamic> _$AdminResponseModelToJson(AdminResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'username': instance.username,
      'password': instance.password,
      'role': instance.role,
      'departmentName': instance.departmentName,
    };
