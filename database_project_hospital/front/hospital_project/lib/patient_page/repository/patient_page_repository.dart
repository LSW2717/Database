import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospital_project/common/dio/dio_view_model.dart';
import 'package:hospital_project/patient_page/model/patient_reservation_request_model.dart';
import 'package:hospital_project/patient_page/model/patient_reservation_response_model.dart';
import 'package:retrofit/http.dart';
import '../../common/const/data.dart';
import '../model/patient_info_response_model.dart';

part 'patient_page_repository.g.dart';

final patientPageRepositoryProvider = Provider<PatientPageRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return PatientPageRepository(dio, baseUrl: 'http://$ip/api/patient');
});

@RestApi()
abstract class PatientPageRepository {
  factory PatientPageRepository(Dio dio, {String baseUrl}) =
      _PatientPageRepository;

  @GET('/{patientId}')
  Future<PatientInfoResponseModel> getPatientInfo(
      @Path('patientId') int patientId);

  @GET('/{patientId}/reservations')
  Future<List<PatientReservationResponseModel>> getPatientReservations(
      @Path('patientId') int patientId);

  @POST('/reservations')
  Future<PatientReservationResponseModel> createReservation(
      @Body() PatientReservationRequestModel request);

  @DELETE('/reservations/{reservationId}')
  Future<void> deleteReservation(@Path('reservationId') int reservationId);
}
