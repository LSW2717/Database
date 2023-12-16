// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connected_patient_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      id: json['id'] as int,
      name: json['name'] as String,
      socialSecurityNumber: json['socialSecurityNumber'] as String,
      gender: json['gender'] as String,
      bloodType: json['bloodType'] as String,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'socialSecurityNumber': instance.socialSecurityNumber,
      'gender': instance.gender,
      'bloodType': instance.bloodType,
      'height': instance.height,
      'weight': instance.weight,
      'phoneNumber': instance.phoneNumber,
    };
