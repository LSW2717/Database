import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hospital_project/doctor_page/model/inpatient_response_model.dart';

import '../../common/secure_storage/secure_storage.dart';
import '../model/examination_info_request_model.dart';
import '../model/examination_info_response_model.dart';
import '../repository/doctor_page_repository.dart';
import 'doctor_page_state.dart';

final doctorPageViewModelProvider =
StateNotifierProvider<DoctorPageViewModel, DoctorPageState>((ref) {
  final repository = ref.watch(doctorPageRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return DoctorPageViewModel(repository, storage);
});

class DoctorPageViewModel extends StateNotifier<DoctorPageState> {
  final DoctorPageRepository repository;
  final FlutterSecureStorage storage;
  int? currentId;
  String selectedCategory = '';

  DoctorPageViewModel(
      this.repository,
      this.storage,
      ) : super(InitialDoctorPage()){
    _loadUserId();
  }

  void setCurrentUserId(int userId) {
    currentId = userId;
  }

  void setSelectedCategory(String category) {
    selectedCategory = category;
    if (category == '개인정보') {
      getDoctorInfo(currentId!);
    } else if (category == '검사현황') {
      getExaminations(currentId!);
    } else if (category == '담당환자') {
      getDoctorInfo(currentId!);
    } else if (category == '입원환자'){
      getInpatients();
    }
  }


  Future<void> getDoctorInfo(int doctorId) async {
    state = DoctorPageLoading();
    try {
      final doctorInfo = await repository.getDoctorWithPatients(doctorId);
      state = DoctorPageLoaded(doctorInfo: doctorInfo);
    } catch (e) {
      state = DoctorPageError(e.toString());
    }
  }

  Future<void> getExaminations(int doctorId) async{
    state = DoctorPageLoading();
    try {
      final examinations = await repository.getExaminationsInfo(doctorId);
      state = DoctorPageLoaded(examinations: examinations);
    } catch (e) {
      state = DoctorPageError(e.toString());
    }
  }

  Future<void> updateExamination(int doctorId, int examinationId, ExaminationInfoRequestModel request) async{
    state = DoctorPageLoading();
    try {
      await repository.updateExamination(doctorId, examinationId, request);
      final List<ExaminationInfoResponseModel> updateExaminations = await repository.getExaminationsInfo(doctorId);
      state = DoctorPageLoaded(examinations: updateExaminations);
    } catch (e) {
      state = DoctorPageError(e.toString());
    }
  }

  Future<void> deleteExamination(int doctorId, int examinationId) async{
    state = DoctorPageLoading();
    try {
      await repository.deleteExamination(doctorId, examinationId);
      await getExaminations(doctorId);
    } catch (e) {
      state = DoctorPageError(e.toString());
    }
  }

  Future<void> getInpatients() async{
    state = DoctorPageLoading();
    try {
      final List<InpatientResponseModel> inpatients = await repository.getAllInpatients();
      state = DoctorPageLoaded(inpatients: inpatients);
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

