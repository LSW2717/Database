import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hospital_project/patient_page/model/patient_reservation_request_model.dart';
import 'package:hospital_project/patient_page/view_model/patient_page_state.dart';
import 'package:hospital_project/patient_page/view_model/patient_page_view_model.dart';
import 'package:intl/intl.dart';

class CreateReservationPage extends ConsumerWidget {
  const CreateReservationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservationState = ref.watch(patientPageViewModelProvider);
    DateTime? selectedDate;
    String? selectedDepartmentName;
    int? patientId;
    if (reservationState is LoadedUserSelectionState){
      selectedDate = reservationState.selectedDate;
      selectedDepartmentName = reservationState.selectedDepartment;
      patientId = reservationState.currentUserId;
    }

    return AlertDialog(
      title: Text('예약하기'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 날짜 선택
            ListTile(
              title: Text(
                  selectedDate == null ? '날짜 선택' : DateFormat('yyyy-MM-dd')
                      .format(selectedDate)),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2025),
                );
                if (picked != null && picked != selectedDate) {
                  ref.read(patientPageViewModelProvider.notifier)
                      .setSelectedDate(picked);
                }
              },
            ),
            // 예약 부서 선택
            DropdownButton<String>(
              value: selectedDepartmentName,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  ref.read(patientPageViewModelProvider.notifier)
                      .setSelectedDepartment(newValue);
                }
              },
              items: <String>['심장과', '신경과', '소아과', '이빈후과', '내과', '외과'].map<
                  DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (selectedDate != null && selectedDepartmentName != null &&
                patientId != null) {
              PatientReservationRequestModel request = PatientReservationRequestModel(
                reservationDateTime: selectedDate,
                departmentName: selectedDepartmentName,
                patientId: patientId,
              );
              await ref.read(patientPageViewModelProvider.notifier).createReservation(request);
            }
          },
          child: Text('Submit'),
        ),
        ElevatedButton(
          onPressed: () {
            context.pop(); // 다이얼로그 닫기
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
