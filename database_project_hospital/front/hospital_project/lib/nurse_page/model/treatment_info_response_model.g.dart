// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_info_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentInfoResponseModel _$TreatmentInfoResponseModelFromJson(
        Map<String, dynamic> json) =>
    TreatmentInfoResponseModel(
      id: json['id'] as int,
      treatmentDateTime: DateTime.parse(json['treatmentDateTime'] as String),
      treatmentDetails: json['treatmentDetails'] as String,
      nurseId: json['nurseId'] as int,
      patient: Patient.fromJson(json['patient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TreatmentInfoResponseModelToJson(
        TreatmentInfoResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'treatmentDateTime': instance.treatmentDateTime.toIso8601String(),
      'treatmentDetails': instance.treatmentDetails,
      'nurseId': instance.nurseId,
      'patient': instance.patient,
    };
