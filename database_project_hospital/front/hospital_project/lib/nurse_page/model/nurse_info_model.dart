import 'package:json_annotation/json_annotation.dart';

import 'connected_patient_info_model.dart';
part 'nurse_info_model.g.dart';

@JsonSerializable()
class NurseInfoModel {
  final int id;
  final String name;
  final String address;
  final String phoneNumber;
  final String departmentName;
  final String role;
  final List<Patient> patients;

  NurseInfoModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.departmentName,
    required this.role,
    required this.patients,
  });

  factory NurseInfoModel.fromJson(Map<String, dynamic> json) => _$NurseInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$NurseInfoModelToJson(this);
}