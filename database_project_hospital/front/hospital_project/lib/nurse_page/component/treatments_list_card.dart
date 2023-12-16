import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospital_project/nurse_page/model/treatment_info_request_model.dart';
import 'package:hospital_project/nurse_page/view_model/nurse_page_view_model.dart';

import '../../common/const/colors.dart';
import '../model/connected_patient_info_model.dart';
import '../model/treatment_info_response_model.dart';

class TreatmentsList extends ConsumerWidget {
  final List<TreatmentInfoResponseModel> treatments;

  const TreatmentsList({
    required this.treatments,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nursePageViewModel = ref.watch(nursePageViewModelProvider.notifier);
    final nursePageState = ref.watch(nursePageViewModelProvider);

    return ListView.builder(
      itemCount: treatments.length,
      itemBuilder: (context, index) {
        final treatment = treatments[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: MAIN_COLOR),
            child: ListTile(
              leading: Icon(Icons.healing),
              title: Text(
                  '환자: ${treatment.patient.name} | 치료: ${treatment.treatmentDetails}'),
              subtitle: Text('날짜: ${treatment.treatmentDateTime.toLocal()}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                // To keep the row size to a minimum
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      final TextEditingController treatmentDetailsController =
                          TextEditingController(
                              text: treatment.treatmentDetails);
                      final TextEditingController treatmentDateController =
                          TextEditingController(
                              text: treatment.treatmentDateTime
                                  .toLocal()
                                  .toString());

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("치료 정보 수정"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextField(
                                  controller: treatmentDetailsController,
                                  decoration:
                                      InputDecoration(labelText: '치료 내용'),
                                ),
                                TextField(
                                  controller: treatmentDateController,
                                  decoration: InputDecoration(labelText: '날짜'),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("취소"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              TextButton(
                                child: Text("저장"),
                                onPressed: () {
                                  final updatedDetails =
                                      treatmentDetailsController.text;
                                  final updatedDate = DateTime.parse(
                                      treatmentDateController.text);
                                  final updateRequest =
                                      TreatmentInfoRequestModel(
                                    treatmentDateTime: updatedDate,
                                    treatmentDetails: updatedDetails,
                                    patientId: treatment.patient.id,
                                  );
                                  nursePageViewModel.updateTreatment(
                                      treatment.nurseId,
                                      treatment.id,
                                      updateRequest);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // 선택적: 사용자에게 삭제를 확인하는 다이얼로그를 표시
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("치료 삭제 확인"),
                            content: Text("이 치료를 정말 삭제하시겠습니까?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("예"),
                                onPressed: () {
                                  nursePageViewModel.deleteTreatment(
                                      treatment.nurseId, treatment.id);
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text("아니오"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              onTap: () {
                _showPatientInfo(context, treatment.patient);
              },
            ),
          ),
        );
      },
    );
  }

  void _showPatientInfo(BuildContext context, Patient patient) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('환자 정보'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('아이디: ${patient.id}'),
                Text('이름: ${patient.name}'),
                Text('혈액형: ${patient.bloodType}'),
                Text('성별: ${patient.gender}'),
                Text('몸무게: ${patient.weight}'),
                Text('키: ${patient.height}'),
                Text('전화번호: ${patient.phoneNumber}'),
                Text('보안번호: ${patient.socialSecurityNumber}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
