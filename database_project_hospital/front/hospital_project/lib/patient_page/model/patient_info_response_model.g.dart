// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_info_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientInfoResponseModel _$PatientInfoResponseModelFromJson(
        Map<String, dynamic> json) =>
    PatientInfoResponseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      gender: json['gender'] as String,
      bloodType: json['bloodType'] as String,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$PatientInfoResponseModelToJson(
        PatientInfoResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gender': instance.gender,
      'bloodType': instance.bloodType,
      'height': instance.height,
      'weight': instance.weight,
      'phoneNumber': instance.phoneNumber,
    };
