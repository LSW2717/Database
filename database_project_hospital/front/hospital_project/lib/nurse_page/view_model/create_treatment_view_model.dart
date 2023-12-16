import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/secure_storage/secure_storage.dart';
import '../model/connected_patient_info_model.dart';
import '../model/treatment_info_request_model.dart';
import '../model/treatment_info_response_model.dart';
import '../repository/nurse_page_repository.dart';
import 'nurse_page_state.dart';

final createTreatmentProvider =
    StateNotifierProvider<CreateTreatment, NursePageState>((ref) {
  final repository = ref.watch(nursePageRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return CreateTreatment(repository, storage);
});

class CreateTreatment extends StateNotifier<NursePageState> {
  final NursePageRepository repository;
  final FlutterSecureStorage storage;

  int? currentId;
  String selectedCategory = '';

  CreateTreatment(
      this.repository,
      this.storage,
      ) : super(InitialNursePage()){
    _loadUserId();
  }

  Future<void> getAllPatients() async{
    state = NursePageLoading();
    try {
      final List<Patient> patients = await repository.getAllPatients();
      state = NursePageLoaded(patients: patients);
    } catch (e) {
      state = NursePageError(e.toString());
    }
  }

  Future<void> createTreatment(int nurseId, TreatmentInfoRequestModel request) async{
    state = NursePageLoading();
    try {
      await repository.createTreatment(nurseId, request);
      final List<TreatmentInfoResponseModel> newTreatments = await repository.getTreatmentsInfo(nurseId);
      state = NursePageLoaded(treatments: newTreatments);
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
