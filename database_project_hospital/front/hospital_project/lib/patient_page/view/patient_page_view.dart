import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hospital_project/patient_page/component/patient_info_card.dart';
import 'package:hospital_project/patient_page/component/patient_reservation_card.dart';
import 'package:hospital_project/patient_page/view_model/patient_page_view_model.dart';
import 'package:hospital_project/start_login_page/view_model/login_page_view_model.dart';

import '../../common/const/colors.dart';
import '../../common/layout/default_layout.dart';
import '../view_model/patient_page_state.dart';
import 'create_reservation_page_view.dart';

class PatientPage extends ConsumerWidget {
  const PatientPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientPageViewModel =
        ref.watch(patientPageViewModelProvider.notifier);
    final patientState = ref.watch(patientPageViewModelProvider);

    String selectedCategory = patientPageViewModel.selectedCategory;

    Widget patientInfoWidget;
    if (patientState is InitialPatientPageState) {
      patientInfoWidget = Center(child: Text('어서오세요 환자 페이지 입니다.'));
    } else if (patientState is LoadingPatientPageState) {
      patientInfoWidget = Center(child: CircularProgressIndicator());
    } else if (patientState is LoadedPatientInfoState) {
      patientInfoWidget = PatientInfo(patientInfo: patientState.patientInfo);
    } else if (patientState is LoadedReservationState) {
      patientInfoWidget = PatientReservation(patientReservation: patientState.reservationInfo);
    } else if (patientState is ErrorPatientPageState) {
      patientInfoWidget = Center(child: Text("Error: ${patientState.message}"));
    } else {
      patientInfoWidget = Center(child: Text("환자 정보를 불러오세요."));
    }

    void _handleLogout(){
      ref.read(loginPageViewModelProvider.notifier).logout();
      context.go('/');
    }
    return DefaultLayout(
      title: 'Patient page',
      onLogout: _handleLogout,
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
                        patientPageViewModel.setSelectedCategory('개인정보');
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
                    color: selectedCategory == '예약조회' ? PRIMARY_COLOR : null,
                    child: ListTile(
                      selected: selectedCategory == '예약조회',
                      onTap: () {
                        patientPageViewModel.setSelectedCategory('예약조회');
                      },
                      title: Text(
                        '예약조회',
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
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => CreateReservationPage());
                          },
                          child: Text(
                            '+ 예약하기',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
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
                        child: patientInfoWidget,
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
