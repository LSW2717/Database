// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_reservation_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientReservationRequestModel _$PatientReservationRequestModelFromJson(
        Map<String, dynamic> json) =>
    PatientReservationRequestModel(
      reservationDateTime:
          DateTime.parse(json['reservationDateTime'] as String),
      departmentName: json['departmentName'] as String,
      patientId: json['patientId'] as int,
    );

Map<String, dynamic> _$PatientReservationRequestModelToJson(
        PatientReservationRequestModel instance) =>
    <String, dynamic>{
      'reservationDateTime': instance.reservationDateTime.toIso8601String(),
      'departmentName': instance.departmentName,
      'patientId': instance.patientId,
    };
