import '../model/admin_response_model.dart';

abstract class AdminPageState {}

class InitialAdminPageState extends AdminPageState {}

class LoadingAdminPageState extends AdminPageState {}

class LoadedAdminPageState extends AdminPageState {
  final List<AdminResponseModel> staff;

  LoadedAdminPageState(this.staff);
}

class ErrorAdminPageState extends AdminPageState {
  final String message;

  ErrorAdminPageState(this.message);
}