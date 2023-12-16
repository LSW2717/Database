import '../../doctor_page/model/inpatient_response_model.dart';
import '../model/connected_patient_info_model.dart';
import '../model/nurse_info_model.dart';
import '../model/treatment_info_response_model.dart';

abstract class NursePageState {}

class InitialNursePage extends NursePageState{}

class NursePageLoading extends NursePageState {}

class NursePageLoaded extends NursePageState {
  final NurseInfoModel? nurseInfo;
  final List<TreatmentInfoResponseModel>? treatments;
  final List<Patient>? patients;
  final List<InpatientResponseModel>? inpatients;

  NursePageLoaded({
    this.nurseInfo,
    this.treatments,
    this.patients,
    this.inpatients,
  });
}

class NursePageError extends NursePageState {
  final String message;

  NursePageError(
      this.message,
      );
}
