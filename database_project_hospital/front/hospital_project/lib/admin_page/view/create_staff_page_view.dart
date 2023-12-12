import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospital_project/admin_page/view_model/admin_page_view_model.dart';

import '../model/admin_request_model.dart';
import '../model/admin_response_model.dart';

class CreateStaffPage extends ConsumerStatefulWidget {
  final Function(AdminResponseModel) onStaffCreated;
  const CreateStaffPage({
    required this.onStaffCreated,
    super.key
  });

  @override
  ConsumerState<CreateStaffPage> createState() => _CreateStaffPageState();
}

class _CreateStaffPageState extends ConsumerState<CreateStaffPage> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final roleController = TextEditingController();
  final departmentNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Staff'),
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
                  .createStaff(requestModel);
              widget.onStaffCreated(response);
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
