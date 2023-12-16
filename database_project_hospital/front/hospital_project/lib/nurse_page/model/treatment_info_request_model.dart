import 'package:json_annotation/json_annotation.dart';
part 'treatment_info_request_model.g.dart';

@JsonSerializable()
class TreatmentInfoRequestModel {
  final DateTime treatmentDateTime;
  final String treatmentDetails;
  final int patientId;
  TreatmentInfoRequestModel({
    required this.treatmentDateTime,
    required this.treatmentDetails,
    required this.patientId,
  });

  factory TreatmentInfoRequestModel.fromJson(Map<String, dynamic> json) => _$TreatmentInfoRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentInfoRequestModelToJson(this);
}