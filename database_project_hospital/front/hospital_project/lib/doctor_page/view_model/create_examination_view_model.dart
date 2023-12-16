import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/secure_storage/secure_storage.dart';
import '../../nurse_page/model/connected_patient_info_model.dart';
import '../model/examination_info_request_model.dart';
import '../model/examination_info_response_model.dart';
import '../repository/doctor_page_repository.dart';
import 'doctor_page_state.dart';

final createExaminationProvider =
StateNotifierProvider<CreateExamination, DoctorPageState>((ref) {
  final repository = ref.watch(doctorPageRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return CreateExamination(repository, storage);
});

class CreateExamination extends StateNotifier<DoctorPageState> {
  final DoctorPageRepository repository;
  final FlutterSecureStorage storage;

  int? currentId;
  String selectedCategory = '';

  CreateExamination(
      this.repository,
      this.storage,
      ) : super(InitialDoctorPage()){
    _loadUserId();
  }

  Future<void> getAllPatients() async{
    state = DoctorPageLoading();
    try {
      final List<Patient> patients = await repository.getAllPatients();
      state = DoctorPageLoaded(patients: patients);
    } catch (e) {
      state = DoctorPageError(e.toString());
    }
  }

  Future<void> createExamination(int doctorId, ExaminationInfoRequestModel request) async{
    state = DoctorPageLoading();
    try {
      await repository.createExamination(doctorId, request);
      final List<ExaminationInfoResponseModel> newExaminations = await repository.getExaminationsInfo(doctorId);
      state = DoctorPageLoaded(examinations: newExaminations);
    } catch (e) {
      state = DoctorPageError(e.toString());
    }
  }


  Future<void> _loadUserId() async {
    final storedUserId = await storage.read(key: "userId");
    if (storedUserId != null) {
      currentId = int.parse(storedUserId);
    }
  }

}
