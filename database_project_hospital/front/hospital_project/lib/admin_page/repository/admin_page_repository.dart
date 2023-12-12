import 'package:dio/dio.dart';
import 'package:hospital_project/admin_page/model/admin_request_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../common/const/data.dart';
import '../../common/dio/dio_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/admin_response_model.dart';
part 'admin_page_repository.g.dart';


final adminPageRepositoryProvider = Provider<AdminPageRepository>((ref) {
  final dio = ref.watch(dioProvider); // dioProvider는 Dio 인스턴스를 제공하는 Provider입니다.
  return AdminPageRepository(dio, baseUrl: 'http://$ip/api/admin');
});

@RestApi()
abstract class AdminPageRepository{
  factory AdminPageRepository(Dio dio, {String baseUrl}) = _AdminPageRepository;

  @GET("/doctors")
  Future<List<AdminResponseModel>> getAllDoctors();

  @GET("/nurses")
  Future<List<AdminResponseModel>> getAllNurses();

  @POST("/staff")
  Future<AdminResponseModel> createStaff(@Body() AdminRequestModel request);

  @PUT("/staff/{id}")
  Future<AdminResponseModel> updateStaff(@Path("id") int id, @Body() AdminRequestModel request);

  @DELETE("/staff/{id}")
  Future<void> deleteStaff(@Path("id") int id);
}

