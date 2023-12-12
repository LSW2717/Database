import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospital_project/admin_page/model/admin_request_model.dart';
import 'package:hospital_project/admin_page/repository/admin_page_repository.dart';

import '../model/admin_response_model.dart';
import 'admin_page_state.dart';

final adminPageViewModelProvider =
StateNotifierProvider<AdminPageViewModel, AdminPageState>(
      (ref) =>
      AdminPageViewModel(ref.watch(
          adminPageRepositoryProvider)),
);

class AdminPageViewModel extends StateNotifier<AdminPageState> {
  final AdminPageRepository _repository;
  String selectedCategory = '';

  AdminPageViewModel(this._repository) : super(InitialAdminPageState());

  void setSelectedCategory(String category){
    selectedCategory = category;
    loadStaffData();
  }

  Future<void> loadStaffData() async {
    try {
      state = LoadingAdminPageState();
      final staff = selectedCategory == 'doctors'
          ? await _repository.getAllDoctors()
          : await _repository.getAllNurses();
      state = LoadedAdminPageState(staff);
    } catch (e){
      state = ErrorAdminPageState(e.toString());
    }
  }

  Future<AdminResponseModel> createStaff(AdminRequestModel request) async {
    try{
      return await _repository.createStaff(request);
    }
    catch (e){
      throw e;
    }
  }
  Future<AdminResponseModel> updateStaff(int id, AdminRequestModel request) async{
    try{
      return await _repository.updateStaff(id, request);
    }
    catch(e){
      throw e;
    }
  }
  Future<void> deleteStaff(int id) async {
    try{
      await _repository.deleteStaff(id);
    }
    catch (e){
      throw e;
    }
  }

}

