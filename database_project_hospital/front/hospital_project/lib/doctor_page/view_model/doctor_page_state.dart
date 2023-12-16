import '../../nurse_page/model/connected_patient_info_model.dart';
import '../model/doctor_info_model.dart';
import '../model/examination_info_response_model.dart';
import '../model/inpatient_response_model.dart';

abstract class DoctorPageState {}

class InitialDoctorPage extends DoctorPageState{}

class DoctorPageLoading extends DoctorPageState {}

class DoctorPageLoaded extends DoctorPageState {
  final DoctorInfoModel? doctorInfo;
  final List<ExaminationInfoResponseModel>? examinations;
  final List<Patient>? patients;
  final List<InpatientResponseModel>? inpatients;

  DoctorPageLoaded({
    this.doctorInfo,
    this.examinations,
    this.patients,
    this.inpatients,
  });
}

class DoctorPageError extends DoctorPageState {
  final String message;

  DoctorPageError(
      this.message,
      );
}
