import 'package:flutter/material.dart';
import 'package:hospital_project/patient_page/model/patient_info_response_model.dart';

import '../../common/const/colors.dart';

class PatientInfo extends StatelessWidget {
  final PatientInfoResponseModel patientInfo;

  const PatientInfo({required this.patientInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 500,
        decoration: BoxDecoration(
          color: MAIN_COLOR,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Icon(
              Icons.person,
              size: 250,
              color: Colors.black,
            ),
            Text(
              '이름: ${patientInfo.name}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 7),
            Text(
              '성별: ${patientInfo.gender}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 7),
            Text(
              '혈액형: ${patientInfo.bloodType}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 7),
            Text(
              '키: ${patientInfo.height}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 7),
            Text(
              '몸무게: ${patientInfo.weight}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 7),
            Text(
              '핸드폰번호: ${patientInfo.phoneNumber}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
