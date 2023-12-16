// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_info_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentInfoRequestModel _$TreatmentInfoRequestModelFromJson(
        Map<String, dynamic> json) =>
    TreatmentInfoRequestModel(
      treatmentDateTime: DateTime.parse(json['treatmentDateTime'] as String),
      treatmentDetails: json['treatmentDetails'] as String,
      patientId: json['patientId'] as int,
    );

Map<String, dynamic> _$TreatmentInfoRequestModelToJson(
        TreatmentInfoRequestModel instance) =>
    <String, dynamic>{
      'treatmentDateTime': instance.treatmentDateTime.toIso8601String(),
      'treatmentDetails': instance.treatmentDetails,
      'patientId': instance.patientId,
    };
