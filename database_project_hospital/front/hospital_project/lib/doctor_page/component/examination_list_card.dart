import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/colors.dart';
import '../../nurse_page/model/connected_patient_info_model.dart';
import '../model/examination_info_request_model.dart';
import '../model/examination_info_response_model.dart';
import 'package:flutter/material.dart';

import '../view_model/doctor_page_view_model.dart';

class ExaminationsList extends ConsumerWidget {
  final List<ExaminationInfoResponseModel> examinations;

  const ExaminationsList({
    required this.examinations,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorPageViewModel = ref.watch(doctorPageViewModelProvider.notifier);

    return ListView.builder(
      itemCount: examinations.length,
      itemBuilder: (context, index) {
        final examination = examinations[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: MAIN_COLOR),
            child: ListTile(
              leading: Icon(Icons.medical_services),
              title: Text(
                  '환자: ${examination.patient.name} | 검사: ${examination.examinationDetails}'),
              subtitle: Text('날짜: ${examination.examinationDateTime.toLocal()}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                // To keep the row size to a minimum
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      final TextEditingController examinationDetailsController =
                      TextEditingController(
                          text: examination.examinationDetails);
                      final TextEditingController examinationDateController =
                      TextEditingController(
                          text: examination.examinationDateTime
                              .toLocal()
                              .toString());

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("검사 정보 수정"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextField(
                                  controller: examinationDetailsController,
                                  decoration:
                                  InputDecoration(labelText: '검사 내용'),
                                ),
                                TextField(
                                  controller: examinationDateController,
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
                                      examinationDetailsController.text;
                                  final updatedDate = DateTime.parse(
                                      examinationDateController.text);
                                  final updateRequest =
                                  ExaminationInfoRequestModel(
                                    examinationDateTime: updatedDate,
                                    examinationDetails: updatedDetails,
                                    patientId: examination.patient.id,
                                  );
                                  doctorPageViewModel.updateExamination(
                                      examination.doctorId,
                                      examination.id,
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
                            title: Text("검사 삭제 확인"),
                            content: Text("이 검사를 정말 삭제하시겠습니까?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("예"),
                                onPressed: () {
                                  doctorPageViewModel.deleteExamination(
                                      examination.doctorId, examination.id);
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
                _showPatientInfo(context, examination.patient);
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
