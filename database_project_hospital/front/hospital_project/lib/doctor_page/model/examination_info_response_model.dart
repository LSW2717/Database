import 'package:json_annotation/json_annotation.dart';

import '../../nurse_page/model/connected_patient_info_model.dart';

part 'examination_info_response_model.g.dart';

@JsonSerializable()
class ExaminationInfoResponseModel {
  final int id;
  final DateTime examinationDateTime;
  final String examinationDetails;
  final int doctorId;
  final Patient patient;

  ExaminationInfoResponseModel({
    required this.id,
    required this.examinationDateTime,
    required this.examinationDetails,
    required this.doctorId,
    required this.patient,
  });

  factory ExaminationInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ExaminationInfoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExaminationInfoResponseModelToJson(this);
}
