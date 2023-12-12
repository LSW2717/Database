import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:hospital_project/start_login_page/model/login_request_model.dart';
import 'package:hospital_project/start_login_page/model/login_response_model.dart';
import '../../common/const/data.dart';
import '../../common/dio/dio_view_model.dart';
import 'package:dio/dio.dart';
part 'login_repository.g.dart';


final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return LoginRepository(dio, baseUrl: 'http://$ip/api/auth');
});

@RestApi()
abstract class LoginRepository{
  factory LoginRepository(Dio dio, {String baseUrl}) = _LoginRepository;
  
  @POST('/login')
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);
}