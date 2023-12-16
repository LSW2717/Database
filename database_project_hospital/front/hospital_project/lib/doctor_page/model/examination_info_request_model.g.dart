// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'examination_info_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExaminationInfoRequestModel _$ExaminationInfoRequestModelFromJson(
        Map<String, dynamic> json) =>
    ExaminationInfoRequestModel(
      examinationDateTime:
          DateTime.parse(json['examinationDateTime'] as String),
      examinationDetails: json['examinationDetails'] as String,
      patientId: json['patientId'] as int,
    );

Map<String, dynamic> _$ExaminationInfoRequestModelToJson(
        ExaminationInfoRequestModel instance) =>
    <String, dynamic>{
      'examinationDateTime': instance.examinationDateTime.toIso8601String(),
      'examinationDetails': instance.examinationDetails,
      'patientId': instance.patientId,
    };
