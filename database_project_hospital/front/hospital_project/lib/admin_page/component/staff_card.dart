import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospital_project/admin_page/view_model/admin_page_view_model.dart';

import '../model/admin_response_model.dart';
import '../view/update_staff_page_view.dart';

class StaffCard extends ConsumerStatefulWidget {
  final List<AdminResponseModel> data;

  const StaffCard({required this.data, super.key});

  @override
  ConsumerState<StaffCard> createState() => _StaffCardState();
}

class _StaffCardState extends ConsumerState<StaffCard> {
  late List<bool> isEditing;
  late List<TextEditingController> controllers;


  @override
  void initState() {
    super.initState();
    isEditing = List.generate(widget.data.length, (index) => false);
    controllers = widget.data.map((staffMember) => TextEditingController(text: staffMember.name)).toList();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final adminViewModel = ref.watch(adminPageViewModelProvider.notifier);
    List<DataRow> rows = widget.data
        .map((staffMember) => DataRow(
              cells: [
                DataCell(Text(
                  staffMember.id.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                )),
                DataCell(Text(
                  staffMember.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                )),
                DataCell(Text(
                  staffMember.address,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                )),
                DataCell(Text(
                  staffMember.phoneNumber,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                )),
                DataCell(Text(
                  staffMember.username,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                )),
                DataCell(Text(
                  staffMember.password,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                )),
                DataCell(Text(
                  staffMember.role,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                )),
                DataCell(Text(
                  staffMember.departmentName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                )),
                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(context: context, builder: (context) => UpdateStaffPage(
                            staffMember: staffMember,
                            onStaffUpdated: (newStaffMember){
                              adminViewModel.loadStaffData();
                            },
                          ));
                        },
                        child: Text('Update'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async{
                          try{
                            final response = ref.read(adminPageViewModelProvider.notifier).deleteStaff(staffMember.id);
                            setState(() {
                              widget.data.removeWhere((item) => item.id == staffMember.id);
                            });
                          }
                          catch(e){
                            throw e;
                          }
                        },
                        child: Text('x'),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))
        .toList();
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          DataTable(
            columnSpacing: 30,
            columns: [
              DataColumn(
                  label: Text(
                'ID',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              )),
              DataColumn(
                  label: Text(
                'Name',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              )),
              DataColumn(
                  label: Text(
                'Adress',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              )),
              DataColumn(
                  label: Text(
                'Phone',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              )),
              DataColumn(
                  label: Text(
                'Username',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              )),
              DataColumn(
                  label: Text(
                'Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              )),
              DataColumn(
                  label: Text(
                'Role',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              )),
              DataColumn(
                  label: Text(
                'Department',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              )),
              DataColumn(
                  label: Text(
                'Actions',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              )),
            ],
            rows: rows,
          ),
          Divider(),
        ],
      ),
    );
  }
}
