import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hospital_project/nurse_page/repository/nurse_page_repository.dart';

import '../../common/secure_storage/secure_storage.dart';
import '../../doctor_page/model/inpatient_response_model.dart';
import '../model/treatment_info_request_model.dart';
import '../model/treatment_info_response_model.dart';
import 'nurse_page_state.dart';

final nursePageViewModelProvider =
    StateNotifierProvider<NursePageViewModel, NursePageState>((ref) {
  final repository = ref.watch(nursePageRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return NursePageViewModel(repository, storage);
});

class NursePageViewModel extends StateNotifier<NursePageState> {
  final NursePageRepository repository;
  final FlutterSecureStorage storage;
  int? currentId;
  String selectedCategory = '';

  NursePageViewModel(
    this.repository,
    this.storage,
  ) : super(InitialNursePage()){
    _loadUserId();
  }

  void setCurrentUserId(int userId) {
    currentId = userId;
  }

  void setSelectedCategory(String category) {
    selectedCategory = category;
    if (category == '개인정보') {
      getNurseInfo(currentId!);
    } else if (category == '치료현황') {
      getTreatments(currentId!);
    } else if (category == '담당환자') {
      getNurseInfo(currentId!);
    } else if (category == '입원환자') {
      getInpatients();
    }
  }


  Future<void> getNurseInfo(int nurseId) async {
    state = NursePageLoading();
    try {
      final nurseInfo = await repository.getNurseWithPatients(nurseId);
      state = NursePageLoaded(nurseInfo: nurseInfo);
    } catch (e) {
      state = NursePageError(e.toString());
    }
  }

  Future<void> getTreatments(int nurseId) async{
    state = NursePageLoading();
    try {
      final treatments = await repository.getTreatmentsInfo(nurseId);
      state = NursePageLoaded(treatments: treatments);
    } catch (e) {
      state = NursePageError(e.toString());
    }
  }

  Future<void> updateTreatment(int nurseId, int treatmentId, TreatmentInfoRequestModel request) async{
    state = NursePageLoading();
    try {
      await repository.updateTreatment(nurseId, treatmentId, request);
      final List<TreatmentInfoResponseModel> updateTreatments = await repository.getTreatmentsInfo(nurseId);
      state = NursePageLoaded(treatments: updateTreatments);
    } catch (e) {
      state = NursePageError(e.toString());
    }
  }

  Future<void> deleteTreatment(int nurseId, int treatmentId) async{
    state = NursePageLoading();
    try {
      await repository.deleteTreatment(nurseId, treatmentId);
      await getTreatments(nurseId);
    } catch (e) {
      state = NursePageError(e.toString());
    }
  }

  Future<void> getInpatients() async{
    state = NursePageLoading();
    try {
      final List<InpatientResponseModel> inpatients = await repository.getAllInpatients();
      state = NursePageLoaded(inpatients: inpatients);
    } catch (e) {
      state = NursePageError(e.toString());
    }
  }


  Future<void> _loadUserId() async {
    final storedUserId = await storage.read(key: "userId");
    if (storedUserId != null) {
      currentId = int.parse(storedUserId);
    }
  }
}
