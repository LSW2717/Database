import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hospital_project/common/secure_storage/secure_storage.dart';
import 'package:hospital_project/patient_page/model/patient_reservation_request_model.dart';
import 'package:hospital_project/patient_page/model/patient_reservation_response_model.dart';
import 'package:hospital_project/patient_page/repository/patient_page_repository.dart';
import 'package:hospital_project/patient_page/view_model/patient_page_state.dart';

final patientPageViewModelProvider =
    StateNotifierProvider<PatientPageViewModel, PatientPageState>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return PatientPageViewModel(
      ref.watch(patientPageRepositoryProvider), secureStorage);
});

class PatientPageViewModel extends StateNotifier<PatientPageState> {
  final PatientPageRepository repository;
  final FlutterSecureStorage secureStorage;
  int? currentUserId;
  String selectedCategory = '';
  DateTime? selectedDate;
  String? selectedDepartmentName;

  PatientPageViewModel(this.repository, this.secureStorage)
      : super(InitialPatientPageState()) {
    _loadUserId();
  }

  void setCurrentUserId(int userId) {
    currentUserId = userId;
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    state = LoadedUserSelectionState(
      selectedDate: selectedDate,
      selectedDepartment: selectedDepartmentName,
      currentUserId: currentUserId,
    );
  }

  void setSelectedDepartment(String departmentName) {
    selectedDepartmentName = departmentName;
    state = LoadedUserSelectionState(
      selectedDate: selectedDate,
      selectedDepartment: selectedDepartmentName,
      currentUserId: currentUserId,
    );
  }

  void setSelectedCategory(String category) {
    selectedCategory = category;
    if (category == '개인정보') {
      getPatientInfo(currentUserId!);
    } else if (category == '예약조회') {
      getPatientReservations(currentUserId!);
    }
  }

  Future<void> getPatientInfo(int patientId) async {
    if (currentUserId == null) {
      state = ErrorPatientPageState("사용자 ID가 설정되지 않았습니다.");
      return;
    }
    state = LoadingPatientPageState();
    try {
      final patientInfo = await repository.getPatientInfo(patientId);
      state = LoadedPatientInfoState(patientInfo);
    } catch (e) {
      state = ErrorPatientPageState(e.toString());
    }
  }

  Future<void> getPatientReservations(int patientId) async {
    state = LoadingPatientPageState();
    try {
      final List<PatientReservationResponseModel> reservationInfo =
          await repository.getPatientReservations(patientId);
      state = LoadedReservationState(reservationInfo);
    } catch (e) {
      state = ErrorPatientPageState(e.toString());
    }
  }

  Future<void> createReservation(PatientReservationRequestModel request) async {
    state = LoadingPatientPageState();
    try {
      await repository.createReservation(request);
      final List<PatientReservationResponseModel> updateReservations =
          await repository.getPatientReservations(currentUserId!);
      state = LoadedReservationState(updateReservations);
    } catch (e) {
      state = ErrorPatientPageState(e.toString());
    }
  }

  Future<void> deleteReservation(int reservationId) async {
    if (currentUserId == null) {
      state = ErrorPatientPageState("사용자 ID가 설정되지 않았습니다.");
      return;
    }
    state = LoadingPatientPageState();
    try {
      await repository.deleteReservation(reservationId);
      // 성공적으로 삭제 후 예약 목록 갱신
      await getPatientReservations(currentUserId!);
    } catch (e) {
      state = ErrorPatientPageState(e.toString());
    }
  }

  Future<void> _loadUserId() async {
    final storedUserId = await secureStorage.read(key: "userId");
    if (storedUserId != null) {
      currentUserId = int.parse(storedUserId);
    }
  }
}
