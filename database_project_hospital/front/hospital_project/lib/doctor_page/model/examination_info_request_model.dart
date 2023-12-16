import 'package:json_annotation/json_annotation.dart';

part 'examination_info_request_model.g.dart';

@JsonSerializable()
class ExaminationInfoRequestModel {
  final DateTime examinationDateTime;
  final String examinationDetails;
  final int patientId;

  ExaminationInfoRequestModel({
    required this.examinationDateTime,
    required this.examinationDetails,
    required this.patientId,
  });

  factory ExaminationInfoRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ExaminationInfoRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExaminationInfoRequestModelToJson(this);
}
