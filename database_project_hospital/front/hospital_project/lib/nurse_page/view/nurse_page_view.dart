import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hospital_project/doctor_page/component/inpatient_info_card.dart';
import 'package:hospital_project/nurse_page/component/nurse_info_card.dart';
import 'package:hospital_project/nurse_page/component/patients_list_card.dart';
import 'package:hospital_project/nurse_page/view/create_treatment_page_view.dart';
import 'package:hospital_project/nurse_page/view_model/nurse_page_view_model.dart';

import '../../common/const/colors.dart';
import '../../common/layout/default_layout.dart';
import '../../start_login_page/view_model/login_page_view_model.dart';
import '../component/treatments_list_card.dart';
import '../view_model/nurse_page_state.dart';

class NursePage extends ConsumerWidget {
  const NursePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nursePageViewModel = ref.watch(nursePageViewModelProvider.notifier);
    final nursePageState = ref.watch(nursePageViewModelProvider);
    String selectedCategory = nursePageViewModel.selectedCategory;

    Widget displaySelectedCategory(String category) {
      if (category == '개인정보' && nursePageState is NursePageLoaded) {
        return NurseInfo(nurseInfo: nursePageState.nurseInfo!);
      } else if (category == '치료현황' && nursePageState is NursePageLoaded) {
        return TreatmentsList(treatments: nursePageState.treatments!);
      } else if (category == '담당환자' && nursePageState is NursePageLoaded) {
        return PatientsList(patients: nursePageState.nurseInfo!.patients);
      } else if (category == '입원환자' && nursePageState is NursePageLoaded) {
        return InPatientsList(inpatients: nursePageState.inpatients!);
      } else if (nursePageState is NursePageLoading) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Center(child: Text('어서오세요 간호사 페이지 입니다.'));
      }
    }

    return DefaultLayout(
      title: 'Nurse page',
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
                        nursePageViewModel.setSelectedCategory('개인정보');
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
                    color: selectedCategory == '치료현황' ? PRIMARY_COLOR : null,
                    child: ListTile(
                      selected: selectedCategory == '치료현황',
                      onTap: () {
                        nursePageViewModel.setSelectedCategory('치료현황');
                      },
                      title: Text(
                        '치료현황',
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
                        nursePageViewModel.setSelectedCategory('담당환자');
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
                        nursePageViewModel.setSelectedCategory('입원환자');
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
                      child: CreateTreatmentPage(),
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
