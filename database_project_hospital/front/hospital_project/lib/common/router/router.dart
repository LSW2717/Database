import 'dart:js';

import 'package:go_router/go_router.dart';
import 'package:hospital_project/admin_page/view/admin_page_view.dart';
import 'package:hospital_project/doctor_page/view/doctor_page_view.dart';

import '../../nurse_page/view/nurse_page_view.dart';
import '../../patient_page/view/patient_page_view.dart';
import '../../start_login_page/view/login_page_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(),
      routes: [
        GoRoute(path: 'Admin',
          builder: (context, state) => AdminPage(),
        ),
        GoRoute(path: 'Doctor',
          builder: (context, state) => DoctorPage(),
        ),
        GoRoute(path: 'Nurse',
          builder: (context, state) => NursePage(),
        ),
        GoRoute(path: 'Patient',
          builder: (context, state) => PatientPage(),
        ),
      ],
    ),
  ],
);
