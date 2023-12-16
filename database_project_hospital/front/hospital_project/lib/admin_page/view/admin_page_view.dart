import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hospital_project/admin_page/model/admin_response_model.dart';
import 'package:hospital_project/admin_page/view_model/admin_page_view_model.dart';
import 'package:hospital_project/common/const/colors.dart';
import 'package:hospital_project/common/layout/default_layout.dart';
import 'package:hospital_project/start_login_page/view_model/login_page_view_model.dart';

import '../component/staff_card.dart';
import '../view_model/admin_page_state.dart';
import 'create_staff_page_view.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminViewModel = ref.watch(adminPageViewModelProvider.notifier);
    final adminPageState = ref.watch(adminPageViewModelProvider);
    final loginState = ref.watch(loginPageViewModelProvider);
    List<AdminResponseModel> data = [];
    if (adminPageState is LoadedAdminPageState) {
      data = adminPageState.staff;
    }
    String selectedCategory = adminViewModel.selectedCategory;

    Widget contentWidget;
    if (selectedCategory.isEmpty) {
      contentWidget = Center(child: Text('어서오세요 admin page 입니다.'));
    } else {
      // 기존의 로직
      contentWidget = StaffCard(data: data);
    }

    void _handleLogout(){
      ref.read(loginPageViewModelProvider.notifier).logout();
      context.go('/');
    }
    return DefaultLayout(
      title: 'admin page',
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
                    color: selectedCategory == 'doctors' ? PRIMARY_COLOR : null,
                    child: ListTile(
                      selected: selectedCategory == 'doctors',
                      onTap: () {
                        adminViewModel.setSelectedCategory('doctors');
                      },
                      title: Text('Doctor',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),),
                      leading: SvgPicture.asset('asset/img/doctor.svg'),
                    ),
                  ),
                  Container(
                    color: selectedCategory == 'nurses' ? PRIMARY_COLOR : null,
                    child: ListTile(
                      selected: selectedCategory == 'nurses',
                      onTap: () {
                        adminViewModel.setSelectedCategory('nurses');
                      },
                      title: Text('Nurse',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),),
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
                            showDialog(context: context, builder: (context) => CreateStaffPage(
                              onStaffCreated: (newStaffMember){
                                adminViewModel.loadStaffData();
                              },
                            ));
                          },
                          child: Text(
                            '+ New Staff',
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
                        child: contentWidget,
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
