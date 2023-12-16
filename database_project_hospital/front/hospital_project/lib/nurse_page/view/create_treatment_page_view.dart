import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../model/connected_patient_info_model.dart';
import '../model/treatment_info_request_model.dart';
import '../view_model/create_treatment_view_model.dart';
import '../view_model/nurse_page_state.dart';
import '../view_model/nurse_page_view_model.dart';

class CreateTreatmentPage extends ConsumerWidget {
  const CreateTreatmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createTreatmentViewModel =
        ref.watch(createTreatmentProvider.notifier);
    final nursePageViewModel = ref.watch(nursePageViewModelProvider.notifier);
    Future<void> openCreateTreatmentDialog() async {
      await createTreatmentViewModel.getAllPatients();
      final createTreatmentState = ref.read(createTreatmentProvider);

      if (createTreatmentState is NursePageLoaded &&
          createTreatmentState.patients!.isNotEmpty) {
        DateTime selectedDate = DateTime.now();
        String treatmentDetails = '';
        int selectedPatientId = createTreatmentState.patients!.first.id;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('치료 추가'),
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
                        treatmentDetails = value;
                      },
                    ),
                    DropdownButton<int>(
                      value: selectedPatientId,
                      onChanged: (int? newValue) {
                        selectedPatientId = newValue!;
                      },
                      items: createTreatmentState.patients!
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
                    TreatmentInfoRequestModel request =
                        TreatmentInfoRequestModel(
                      treatmentDateTime: selectedDate,
                      treatmentDetails: treatmentDetails,
                      patientId: selectedPatientId,
                    );
                    await createTreatmentViewModel.createTreatment(
                        createTreatmentViewModel.currentId!, request);
                    await nursePageViewModel
                        .getTreatments(createTreatmentViewModel.currentId!);
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
      } else if (createTreatmentState is NursePageLoading) {
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
        onPressed: openCreateTreatmentDialog,
        child: Text(
          '+ 치료 추가',
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
