

import '../../common/const/colors.dart';
import '../model/doctor_info_model.dart';
import 'package:flutter/material.dart';

class DoctorInfo extends StatelessWidget {
  final DoctorInfoModel doctorInfo;
  const DoctorInfo({
    required this.doctorInfo,
    super.key,
  });

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
              'id: ${doctorInfo.id}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 7),
            Text(
              '이름: ${doctorInfo.name}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 7),
            Text(
              '주소: ${doctorInfo.address}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 7),
            Text(
              '핸드폰번호: ${doctorInfo.phoneNumber}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '부서이름: ${doctorInfo.departmentName}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '직업: ${doctorInfo.role}',
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
