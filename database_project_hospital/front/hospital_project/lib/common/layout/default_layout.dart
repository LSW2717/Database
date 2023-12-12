import 'package:flutter/material.dart';
import 'package:hospital_project/common/const/colors.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? drawer;

  const DefaultLayout({
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    this.drawer,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: defaultAppBar(),
      drawer: drawer,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? defaultAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        toolbarHeight: 80,
        leading: Icon(Icons.local_hospital, size: 40), // 병원 아이콘
        title: Text(
          title!, // 이 부분은 기존에 정의된 타이틀을 사용
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false, // 타이틀을 왼쪽으로 정렬
      );
    }
  }
}
