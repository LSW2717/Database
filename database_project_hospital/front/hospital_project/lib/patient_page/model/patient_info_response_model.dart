import 'package:json_annotation/json_annotation.dart';
part 'patient_info_response_model.g.dart';

@JsonSerializable()
class PatientInfoResponseModel {
  final int id;
  final String name;
  final String gender;
  final String bloodType;
  final double height;
  final double weight;
  final String phoneNumber;

  PatientInfoResponseModel(
      {required this.id,
      required this.name,
      required this.gender,
      required this.bloodType,
      required this.height,
      required this.weight,
      required this.phoneNumber});

  factory PatientInfoResponseModel.fromJson(Map<String, dynamic> json)
  => _$PatientInfoResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$PatientInfoResponseModelToJson(this);
}
