import 'package:json_annotation/json_annotation.dart';

part 'patient_reservation_request_model.g.dart';

@JsonSerializable()
class PatientReservationRequestModel {
  final DateTime reservationDateTime;
  final String departmentName;
  final int patientId;

  PatientReservationRequestModel({
    required this.reservationDateTime,
    required this.departmentName,
    required this.patientId,
  });

  factory PatientReservationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PatientReservationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientReservationRequestModelToJson(this);
}
