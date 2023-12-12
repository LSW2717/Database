import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hospital_project/patient_page/view_model/patient_page_view_model.dart';
import 'package:hospital_project/start_login_page/component/custom_text_form_field.dart';
import 'package:hospital_project/start_login_page/model/login_request_model.dart';
import 'package:hospital_project/start_login_page/view_model/login_page_view_model.dart';

import '../../common/const/colors.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginPageViewModelProvider);

    Widget _buildStateUI() {
      if (loginState is LoadingLoginState) {
        return const CircularProgressIndicator();
      } else if (loginState is ErrorLoginState) {
        return Text(loginState.errorMessage);
      } else if (loginState is SuccessLoginState) {
        final patientPageViewModel =
            ref.read(patientPageViewModelProvider.notifier);
        patientPageViewModel.setCurrentUserId(loginState.id);
        Future.microtask(() => context.go('/${loginState.userType}'));
        return Container();
      }
      return Container();
    }

    String username = '';
    String password = '';

    return Scaffold(
      backgroundColor: MAIN_COLOR,
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_hospital,
                    size: 300,
                    color: PRIMARY_COLOR,
                  ),
                  Container(
                    width: 300,
                    child: CustomTextFormField(
                      hintText: '아이디를 입력해주세요',
                      onChanged: (String value) {
                        username = value;
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    width: 300,
                    child: CustomTextFormField(
                      hintText: '비밀번호를 입력해주세요',
                      onChanged: (String value) {
                        password = value;
                      },
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      final loginRequest = LoginRequestModel(
                          username: username, password: password);
                      ref
                          .read(loginPageViewModelProvider.notifier)
                          .login(loginRequest);
                    },
                    child: Text('login'),
                  ),
                  _buildStateUI(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
