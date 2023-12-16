import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hospital_project/common/layout/default_layout.dart';
import 'package:hospital_project/doctor_page/component/inpatient_info_card.dart';

import '../../common/const/colors.dart';
import '../../nurse_page/component/patients_list_card.dart';
import '../../start_login_page/view_model/login_page_view_model.dart';
import '../component/doctor_info_card.dart';
import '../component/examination_list_card.dart';
import '../view_model/doctor_page_state.dart';
import '../view_model/doctor_page_view_model.dart';
import 'create_examination_page_view.dart';


class DoctorPage extends ConsumerWidget {
  const DoctorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorPageViewModel = ref.watch(doctorPageViewModelProvider.notifier);
    final doctorPageState = ref.watch(doctorPageViewModelProvider);
    String selectedCategory = doctorPageViewModel.selectedCategory;

    Widget displaySelectedCategory(String category) {
      if (category == '개인정보' && doctorPageState is DoctorPageLoaded) {
        return DoctorInfo(doctorInfo: doctorPageState.doctorInfo!);
      } else if (category == '검사현황' && doctorPageState is DoctorPageLoaded) {
        return ExaminationsList(examinations: doctorPageState.examinations!);
      } else if (category == '담당환자' && doctorPageState is DoctorPageLoaded) {
        return PatientsList(patients: doctorPageState.doctorInfo!.patients);
      } else if (category == '입원환자' && doctorPageState is DoctorPageLoaded) {
        return InPatientsList(inpatients: doctorPageState.inpatients!);
      } else if (doctorPageState is DoctorPageLoading) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Center(child: Text('어서오세요 의사 페이지 입니다.'));
      }
    }

    return DefaultLayout(
      title: 'Doctor page',
      onLogout: () {
        ref.read(loginPageViewModelProvider.notifier).logout();
        context.go('/');
      },
      child: Container(
        color: MAIN_COLOR,
        child: Row(
          children: [
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: [
                  Container(
                    color: selectedCategory == '개인정보' ? PRIMARY_COLOR : null,
                    child: ListTile(
                      selected: selectedCategory == '개인정보',
                      onTap: () {
                        doctorPageViewModel.setSelectedCategory('개인정보');
                      },
                      title: Text(
                        '개인정보',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: SvgPicture.asset('asset/img/doctor.svg'),
                    ),
                  ),
                  Container(
                    color: selectedCategory == '검사현황' ? PRIMARY_COLOR : null,
                    child: ListTile(
                      selected: selectedCategory == '검사현황',
                      onTap: () {
                        doctorPageViewModel.setSelectedCategory('검사현황');
                      },
                      title: Text(
                        '검사현황',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: SvgPicture.asset('asset/img/doctor.svg'),
                    ),
                  ),
                  Container(
                    color: selectedCategory == '담당환자' ? PRIMARY_COLOR : null,
                    child: ListTile(
                      selected: selectedCategory == '담당환자',
                      onTap: () {
                        doctorPageViewModel.setSelectedCategory('담당환자');
                      },
                      title: Text(
                        '담당환자',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: SvgPicture.asset('asset/img/doctor.svg'),
                    ),
                  ),
                  Container(
                    color: selectedCategory == '입원환자' ? PRIMARY_COLOR : null,
                    child: ListTile(
                      selected: selectedCategory == '입원환자',
                      onTap: () {
                        doctorPageViewModel.setSelectedCategory('입원환자');
                      },
                      title: Text(
                        '입원환자',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: SvgPicture.asset('asset/img/doctor.svg'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CreateExaminationPage(),
                    ),
                    Expanded(
                      flex: 15,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: displaySelectedCategory(selectedCategory),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
