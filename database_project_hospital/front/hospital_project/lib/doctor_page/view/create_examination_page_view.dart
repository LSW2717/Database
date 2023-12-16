

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../nurse_page/model/connected_patient_info_model.dart';
import '../model/examination_info_request_model.dart';
import '../view_model/create_examination_view_model.dart';
import '../view_model/doctor_page_state.dart';
import '../view_model/doctor_page_view_model.dart';

class CreateExaminationPage extends ConsumerWidget {
  const CreateExaminationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createExaminationViewModel =
    ref.watch(createExaminationProvider.notifier);
    final doctorPageViewModel = ref.watch(doctorPageViewModelProvider.notifier);
    Future<void> openCreateExaminationDialog() async {
      await createExaminationViewModel.getAllPatients();
      final createExaminationState = ref.read(createExaminationProvider);

      if (createExaminationState is DoctorPageLoaded &&
          createExaminationState.patients!.isNotEmpty) {
        DateTime selectedDate = DateTime.now();
        String examinationDetails = '';
        int selectedPatientId = createExaminationState.patients!.first.id;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('검사 추가'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                          "날짜 선택: ${DateFormat('yyyy-MM-dd').format(selectedDate)}"),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                        );
                        if (picked != null && picked != selectedDate) {
                          selectedDate = picked;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: '세부사항'),
                      onChanged: (value) {
                        examinationDetails = value;
                      },
                    ),
                    DropdownButton<int>(
                      value: selectedPatientId,
                      onChanged: (int? newValue) {
                        selectedPatientId = newValue!;
                      },
                      items: createExaminationState.patients!
                          .map<DropdownMenuItem<int>>((Patient patient) {
                        return DropdownMenuItem<int>(
                          value: patient.id,
                          child: Text(patient.name),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('저장'),
                  onPressed: () async {
                    ExaminationInfoRequestModel request =
                    ExaminationInfoRequestModel(
                      examinationDateTime: selectedDate,
                      examinationDetails: examinationDetails,
                      patientId: selectedPatientId,
                    );
                    await createExaminationViewModel.createExamination(
                        createExaminationViewModel.currentId!, request);
                    await doctorPageViewModel
                        .getExaminations(createExaminationViewModel.currentId!);
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: Text('취소'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      } else if (createExaminationState is DoctorPageLoading) {
        Center(child: CircularProgressIndicator());
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('오류'),
            content: Text('환자 목록을 불러올 수 없습니다.'),
            actions: [
              ElevatedButton(
                child: Text('확인'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    }
    return Container(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: openCreateExaminationDialog,
        child: Text(
          '+ 검사 추가',
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
