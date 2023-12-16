import 'package:dio/dio.dart';
import 'package:hospital_project/common/dio/dio_view_model.dart';
import 'package:hospital_project/nurse_page/model/treatment_info_response_model.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/const/data.dart';
import '../../doctor_page/model/inpatient_response_model.dart';
import '../model/connected_patient_info_model.dart';
import '../model/nurse_info_model.dart';
import '../model/treatment_info_request_model.dart';

part 'nurse_page_repository.g.dart';

@Riverpod(keepAlive: true)
NursePageRepository nursePageRepository(NursePageRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  return NursePageRepository(dio, baseUrl: 'http://$ip/api/nurse');
}

@RestApi()
abstract class NursePageRepository {
  factory NursePageRepository(Dio dio, {String baseUrl}) = _NursePageRepository;

  @GET('/patients')
  Future<List<Patient>> getAllPatients();

  @GET('/{nurseId}/patients')
  Future<NurseInfoModel> getNurseWithPatients(@Path('nurseId') int nurseId);

  @GET('/{nurseId}/treatments')
  Future<List<TreatmentInfoResponseModel>> getTreatmentsInfo(@Path('nurseId') int nurseId);

  @POST('/{nurseId}/treatments')
  Future<TreatmentInfoResponseModel> createTreatment(@Path('nurseId') int nurseId, @Body() TreatmentInfoRequestModel request);

  @PUT('/{nurseId}/treatments/{treatmentId}')
  Future<TreatmentInfoResponseModel> updateTreatment(@Path('nurseId') int nurseId, @Path('treatmentId') int treatmentId, @Body() TreatmentInfoRequestModel request);

  @DELETE('/{nurseId}/treatments/{treatmentId}')
  Future<void> deleteTreatment(@Path('nurseId') int nurseId, @Path('treatmentId') int treatmentId);

  @GET('/inpatients')
  Future<List<InpatientResponseModel>> getAllInpatients();
}
