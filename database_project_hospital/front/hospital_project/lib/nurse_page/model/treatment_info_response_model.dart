import 'package:json_annotation/json_annotation.dart';

import 'connected_patient_info_model.dart';

part 'treatment_info_response_model.g.dart';

@JsonSerializable()
class TreatmentInfoResponseModel {
  final int id;
  final DateTime treatmentDateTime;
  final String treatmentDetails;
  final int nurseId;
  final Patient patient;
  TreatmentInfoResponseModel({
    required this.id,
    required this.treatmentDateTime,
    required this.treatmentDetails,
    required this.nurseId,
    required this.patient,
  });

  factory TreatmentInfoResponseModel.fromJson(Map<String, dynamic> json) => _$TreatmentInfoResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentInfoResponseModelToJson(this);
}