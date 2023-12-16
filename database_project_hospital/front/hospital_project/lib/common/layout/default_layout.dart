import 'package:flutter/material.dart';
import 'package:hospital_project/start_login_page/view_model/login_page_view_model.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final VoidCallback? onLogout;

  const DefaultLayout({
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    this.drawer,
    required this.child,
    this.onLogout,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: defaultAppBar(context),
      drawer: drawer,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? defaultAppBar(BuildContext context) {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        toolbarHeight: 80,
        leading: Icon(Icons.local_hospital, size: 40), // 병원 아이콘
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title!, // 이 부분은 기존에 정의된 타이틀을 사용
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
              ),
            ),
            if (onLogout != null)
            TextButton(
              onPressed: onLogout,
              child: Text(
                '로그아웃',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        centerTitle: false, // 타이틀을 왼쪽으로 정렬
      );
    }
  }
}
