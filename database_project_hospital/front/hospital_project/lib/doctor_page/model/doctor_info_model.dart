import 'package:json_annotation/json_annotation.dart';

import '../../nurse_page/model/connected_patient_info_model.dart';

part 'doctor_info_model.g.dart';

@JsonSerializable()
class DoctorInfoModel {
  final int id;
  final String name;
  final String address;
  final String phoneNumber;
  final String departmentName;
  final String role;
  final List<Patient> patients;

  DoctorInfoModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.departmentName,
    required this.role,
    required this.patients,
  });

  factory DoctorInfoModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorInfoModelToJson(this);
}
