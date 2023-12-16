import 'package:flutter/material.dart';
import 'package:hospital_project/doctor_page/model/inpatient_response_model.dart';
import 'package:intl/intl.dart';

import '../../common/const/colors.dart';

class InPatientsList extends StatelessWidget {
  final List<InpatientResponseModel> inpatients;

  const InPatientsList({
    required this.inpatients,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: inpatients.length,
      itemBuilder: (contest, index) {
        final inpatient = inpatients[index];
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Container(
              width: 400,
              height: 200,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: MAIN_COLOR,
                  borderRadius: BorderRadius.circular(
                    10.0,
                  )),
              child: Row(
                children: [
                  Icon(
                    Icons.bed,
                    size: 150,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text('입원호실: ${inpatient.roomInformation}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 40),
                      Text('환자번호: ${inpatient.patientId}'),
                      Text('입원날짜: ${DateFormat('yyyy-MM-dd HH:mm').format(inpatient.admissionDateTime)}'),
                      Text('퇴원날짜: ${DateFormat('yyyy-MM-dd HH:mm').format(inpatient.dischargeDateTime)}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}