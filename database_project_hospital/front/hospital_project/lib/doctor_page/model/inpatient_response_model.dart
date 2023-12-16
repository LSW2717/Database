import 'package:json_annotation/json_annotation.dart';

part 'inpatient_response_model.g.dart';

@JsonSerializable()
class InpatientResponseModel {
  final int inpatientId;
  final int patientId;
  final String roomInformation;
  final DateTime admissionDateTime;
  final DateTime dischargeDateTime;
  InpatientResponseModel({
    required this.inpatientId,
    required this.patientId,
    required this.roomInformation,
    required this.admissionDateTime,
    required this.dischargeDateTime,
  });

  factory InpatientResponseModel.fromJson(Map<String, dynamic> json) => _$InpatientResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$InpatientResponseModelToJson(this);
}