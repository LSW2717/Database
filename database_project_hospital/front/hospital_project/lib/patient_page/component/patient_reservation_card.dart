import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospital_project/patient_page/model/patient_reservation_response_model.dart';
import 'package:hospital_project/patient_page/view_model/patient_page_view_model.dart';
import 'package:intl/intl.dart';

class PatientReservation extends ConsumerWidget {
  final List<PatientReservationResponseModel> patientReservation;

  const PatientReservation({
    required this.patientReservation,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientViewModel = ref.watch(patientPageViewModelProvider.notifier);
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          DataTable(
            columnSpacing: 100,
            columns: [
              DataColumn(
                  label: Text(
                '예약번호',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              )),
              DataColumn(
                  label: Text(
                '부서이름',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              )),
              DataColumn(
                  label: Text(
                '예약날짜',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              )),
              DataColumn(
                  label: Text(
                    '예약취소',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ],
            rows: patientReservation
                .map((reservation) => DataRow(
                      cells: [
                        DataCell(Text(reservation.reservationId.toString())),
                        DataCell(Text(reservation.departmentName)),
                        DataCell(Text(DateFormat('yyyy-MM-dd')
                            .format(reservation.reservationDateTime))),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await patientViewModel.deleteReservation(reservation.reservationId);
                                },
                                child: Text('x'),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
