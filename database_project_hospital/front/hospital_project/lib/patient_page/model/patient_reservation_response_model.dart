import 'package:json_annotation/json_annotation.dart';
import '../../common/utils/data_utils.dart';

part 'patient_reservation_response_model.g.dart';

@JsonSerializable()
class PatientReservationResponseModel {
  final int reservationId;
  @JsonKey(fromJson: DataUtils.stringToDateTime)
  final DateTime reservationDateTime;
  final String departmentName;
  final int patientId;

  PatientReservationResponseModel(
      {required this.reservationId,
      required this.reservationDateTime,
      required this.departmentName,
      required this.patientId});

  factory PatientReservationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PatientReservationResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientReservationResponseModelToJson(this);
}
