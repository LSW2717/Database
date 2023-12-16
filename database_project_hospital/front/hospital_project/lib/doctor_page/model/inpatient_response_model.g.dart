// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inpatient_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InpatientResponseModel _$InpatientResponseModelFromJson(
        Map<String, dynamic> json) =>
    InpatientResponseModel(
      inpatientId: json['inpatientId'] as int,
      patientId: json['patientId'] as int,
      roomInformation: json['roomInformation'] as String,
      admissionDateTime: DateTime.parse(json['admissionDateTime'] as String),
      dischargeDateTime: DateTime.parse(json['dischargeDateTime'] as String),
    );

Map<String, dynamic> _$InpatientResponseModelToJson(
        InpatientResponseModel instance) =>
    <String, dynamic>{
      'inpatientId': instance.inpatientId,
      'patientId': instance.patientId,
      'roomInformation': instance.roomInformation,
      'admissionDateTime': instance.admissionDateTime.toIso8601String(),
      'dischargeDateTime': instance.dischargeDateTime.toIso8601String(),
    };
