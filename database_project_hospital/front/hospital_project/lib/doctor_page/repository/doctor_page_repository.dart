import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio_view_model.dart';
import '../../nurse_page/model/connected_patient_info_model.dart';
import '../model/doctor_info_model.dart';
import '../model/examination_info_request_model.dart';
import '../model/examination_info_response_model.dart';
import '../model/inpatient_response_model.dart';
part 'doctor_page_repository.g.dart';

@Riverpod(keepAlive: true)
DoctorPageRepository doctorPageRepository(DoctorPageRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  return DoctorPageRepository(dio, baseUrl: 'http://$ip/api/doctor');
}

@RestApi()
abstract class DoctorPageRepository{
  factory DoctorPageRepository(Dio dio, {String baseUrl}) = _DoctorPageRepository;
  @GET('/patients')
  Future<List<Patient>> getAllPatients();

  @GET('/{doctorId}/patients')
  Future<DoctorInfoModel> getDoctorWithPatients(@Path('doctorId') int doctorId);

  @GET('/{doctorId}/examinations')
  Future<List<ExaminationInfoResponseModel>> getExaminationsInfo(@Path('doctorId') int doctorId);

  @POST('/{doctorId}/examinations')
  Future<ExaminationInfoResponseModel> createExamination(@Path('doctorId') int doctorId, @Body() ExaminationInfoRequestModel request);

  @PUT('/{doctorId}/examinations/{examinationId}')
  Future<ExaminationInfoResponseModel> updateExamination(@Path('doctorId') int doctorId, @Path('examinationId') int examinationId, @Body() ExaminationInfoRequestModel request);

  @DELETE('/{doctorId}/examinations/{examinationId}')
  Future<void> deleteExamination(@Path('doctorId') int doctorId, @Path('examinationId') int examinationId);

  @GET('/inpatients')
  Future<List<InpatientResponseModel>> getAllInpatients();

}
