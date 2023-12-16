import 'package:json_annotation/json_annotation.dart';
part 'connected_patient_info_model.g.dart';

@JsonSerializable()
class Patient {
  final int id;
  final String name;
  final String socialSecurityNumber;
  final String gender;
  final String bloodType;
  final double height;
  final double weight;
  final String phoneNumber;
  Patient({
    required this.id,
    required this.name,
    required this.socialSecurityNumber,
    required this.gender,
    required this.bloodType,
    required this.height,
    required this.weight,
    required this.phoneNumber,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);
  Map<String, dynamic> toJson() => _$PatientToJson(this);
}