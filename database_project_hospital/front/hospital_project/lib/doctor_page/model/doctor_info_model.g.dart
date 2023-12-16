// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorInfoModel _$DoctorInfoModelFromJson(Map<String, dynamic> json) =>
    DoctorInfoModel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      departmentName: json['departmentName'] as String,
      role: json['role'] as String,
      patients: (json['patients'] as List<dynamic>)
          .map((e) => Patient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoctorInfoModelToJson(DoctorInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'departmentName': instance.departmentName,
      'role': instance.role,
      'patients': instance.patients,
    };
