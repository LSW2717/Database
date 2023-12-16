// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'examination_info_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExaminationInfoResponseModel _$ExaminationInfoResponseModelFromJson(
        Map<String, dynamic> json) =>
    ExaminationInfoResponseModel(
      id: json['id'] as int,
      examinationDateTime:
          DateTime.parse(json['examinationDateTime'] as String),
      examinationDetails: json['examinationDetails'] as String,
      doctorId: json['doctorId'] as int,
      patient: Patient.fromJson(json['patient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExaminationInfoResponseModelToJson(
        ExaminationInfoResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'examinationDateTime': instance.examinationDateTime.toIso8601String(),
      'examinationDetails': instance.examinationDetails,
      'doctorId': instance.doctorId,
      'patient': instance.patient,
    };
