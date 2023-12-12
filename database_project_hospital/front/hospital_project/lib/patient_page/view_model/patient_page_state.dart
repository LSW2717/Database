import '../model/patient_info_response_model.dart';
import '../model/patient_reservation_response_model.dart';

abstract class PatientPageState {}

class InitialPatientPageState extends PatientPageState {}

class LoadingPatientPageState extends PatientPageState {}

class LoadedPatientInfoState extends PatientPageState {
  final PatientInfoResponseModel patientInfo;

  LoadedPatientInfoState(
    this.patientInfo,
  );
}

class LoadedReservationState extends PatientPageState {
  final List<PatientReservationResponseModel> reservationInfo;

  LoadedReservationState(
    this.reservationInfo,
  );
}

class LoadedUserSelectionState extends PatientPageState {
  final DateTime? selectedDate;
  final String? selectedDepartment;
  final int? currentUserId;

  LoadedUserSelectionState({
    this.selectedDate,
    this.selectedDepartment,
    this.currentUserId,
  });
}

class ErrorPatientPageState extends PatientPageState {
  final String message;

  ErrorPatientPageState(this.message);
}
