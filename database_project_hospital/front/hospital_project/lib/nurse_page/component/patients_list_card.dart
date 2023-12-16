import 'package:flutter/material.dart';

import '../../common/const/colors.dart';
import '../model/connected_patient_info_model.dart';

class PatientsList extends StatelessWidget {
  final List<Patient> patients;

  const PatientsList({
    required this.patients,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (contest, index) {
        final patient = patients[index];
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
                    Icons.person,
                    size: 200,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('이름: ${patient.name}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('ID: ${patient.id}'),
                      Text('혈액형: ${patient.bloodType}'),
                      Text('성별: ${patient.gender}'),
                      Text('몸무게: ${patient.weight}'),
                      Text('키: ${patient.height}'),
                      Text('전화번호: ${patient.phoneNumber}'),
                      Text('보안번호: ${patient.socialSecurityNumber}'),
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
