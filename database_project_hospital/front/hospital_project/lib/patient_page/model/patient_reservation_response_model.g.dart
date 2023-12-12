// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_reservation_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientReservationResponseModel _$PatientReservationResponseModelFromJson(
        Map<String, dynamic> json) =>
    PatientReservationResponseModel(
      reservationId: json['reservationId'] as int,
      reservationDateTime:
          DataUtils.stringToDateTime(json['reservationDateTime'] as String),
      departmentName: json['departmentName'] as String,
      patientId: json['patientId'] as int,
    );

Map<String, dynamic> _$PatientReservationResponseModelToJson(
        PatientReservationResponseModel instance) =>
    <String, dynamic>{
      'reservationId': instance.reservationId,
      'reservationDateTime': instance.reservationDateTime.toIso8601String(),
      'departmentName': instance.departmentName,
      'patientId': instance.patientId,
    };
