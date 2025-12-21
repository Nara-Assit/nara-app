import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/features/auth/widgets/login_widget.dart';
import 'package:nara/features/auth/widgets/register_widget.dart';

class AuthScreen extends StatelessWidget {
  final int index;
  const AuthScreen({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        initialIndex: index,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              const TabBar(
                indicatorSize: .tab,
                indicatorWeight: 3,
                dividerColor: ColorManager.secondColor,
                dividerHeight: 1.2,
                tabs: [
                  Tab(
                    child: Text(
                      "تسجيل الدخول",
                    ),
                  ),
                  Tab(
                    child: Text(
                      "انشاء حساب",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [const LoginWidget(), RegisterWidget()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
