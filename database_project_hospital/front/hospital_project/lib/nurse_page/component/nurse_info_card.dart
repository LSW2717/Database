import 'package:flutter/material.dart';
import 'package:hospital_project/nurse_page/model/nurse_info_model.dart';

import '../../common/const/colors.dart';

class NurseInfo extends StatelessWidget {
  final NurseInfoModel nurseInfo;
  const NurseInfo({
    required this.nurseInfo,
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
              'id: ${nurseInfo.id}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 7),
            Text(
              '이름: ${nurseInfo.name}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 7),
            Text(
              '주소: ${nurseInfo.address}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 7),
            Text(
              '핸드폰번호: ${nurseInfo.phoneNumber}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '부서이름: ${nurseInfo.departmentName}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '직업: ${nurseInfo.role}',
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
