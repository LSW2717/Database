import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hospital_project/common/secure_storage/secure_storage.dart';
import 'package:hospital_project/start_login_page/model/login_request_model.dart';
import 'package:hospital_project/start_login_page/repository/login_repository.dart';

final loginPageViewModelProvider =
    StateNotifierProvider<LoginPageViewModel, LoginState>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return LoginPageViewModel(ref.watch(loginRepositoryProvider), secureStorage);
});

class LoginPageViewModel extends StateNotifier<LoginState> {
  final LoginRepository loginRepository;
  final FlutterSecureStorage secureStorage;

  LoginPageViewModel(this.loginRepository, this.secureStorage)
      : super(InitialLoginState());

  Future<void> login(LoginRequestModel request) async {
    state = LoadingLoginState();
    try {
      final response = await loginRepository.login(request);
      await secureStorage.write(key: "userId", value: response.id.toString());
      state = SuccessLoginState(
          id: response.id,
          username: response.username,
          userType: response.userType);
    } catch (e) {
      state = ErrorLoginState(errorMessage: e.toString());
    }
  }
}

abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  final int id;
  final String username;
  final String userType;

  SuccessLoginState({
    required this.id,
    required this.username,
    required this.userType,
  });
}

class ErrorLoginState extends LoginState {
  final String errorMessage;

  ErrorLoginState({
    required this.errorMessage,
  });
}
