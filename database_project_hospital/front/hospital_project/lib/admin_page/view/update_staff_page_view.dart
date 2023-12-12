import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/admin_request_model.dart';
import '../model/admin_response_model.dart';
import '../view_model/admin_page_view_model.dart';



class UpdateStaffPage extends ConsumerStatefulWidget {
  final AdminResponseModel staffMember;
  final Function(AdminResponseModel) onStaffUpdated;
  const UpdateStaffPage({
    required this.staffMember,
    required this.onStaffUpdated,
    super.key
  });

  @override
  ConsumerState<UpdateStaffPage> createState() => _UpdateStaffPageState();
}

class _UpdateStaffPageState extends ConsumerState<UpdateStaffPage> {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController phoneNumberController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController roleController;
  late TextEditingController departmentNameController;

  @override
  void initState(){
    super.initState();
    nameController = TextEditingController(text: widget.staffMember.name);
    addressController = TextEditingController(text: widget.staffMember.address);
    phoneNumberController = TextEditingController(text: widget.staffMember.phoneNumber);
    usernameController = TextEditingController(text: widget.staffMember.username);
    passwordController = TextEditingController(text: widget.staffMember.password);
    roleController = TextEditingController(text: widget.staffMember.role);
    departmentNameController = TextEditingController(text: widget.staffMember.departmentName);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Staff'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Adress'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: roleController,
              decoration: InputDecoration(labelText: 'Role'),
            ),
            TextField(
              controller: departmentNameController,
              decoration: InputDecoration(labelText: 'Department Name'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            final requestModel = AdminRequestModel(
              name: nameController.text,
              address: addressController.text,
              phoneNumber: phoneNumberController.text,
              username: usernameController.text,
              password: passwordController.text,
              role: roleController.text,
              departmentName: departmentNameController.text,
            );
            try {
              final response = await ref
                  .read(adminPageViewModelProvider.notifier)
                  .updateStaff(widget.staffMember.id,requestModel);
              widget.onStaffUpdated(response);
              Navigator.of(context).pop();
            } catch (e) {
              throw e;
            }
          },
          child: Text('Submit'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    roleController.dispose();
    departmentNameController.dispose();
    super.dispose();
  }
}
