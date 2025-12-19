import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/core/theming/text_style_manager.dart';
import '../../../core/helpers/app_assets.dart';
import '../logic/change_bottom_nav_bar_index.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeBottomNavBarIndex(),
      child: BlocBuilder<ChangeBottomNavBarIndex, int>(
        builder: (context, index) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: Stack(
              children: [
                Container(
                  height: 56.h,
                  margin: EdgeInsets.only(
                    bottom: 26.h,
                    left: 24.w,
                    right: 83.w,
                    top: 60.h,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: ColorManager.primaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.r),
                      bottomLeft: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r),
                    ),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      canvasColor: Colors.transparent,
                    ),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      child: BottomNavigationBar(
                        currentIndex: index,
                        elevation: 0,
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: Colors.transparent,
                        selectedItemColor: ColorManager.yellowColor,
                        unselectedItemColor: ColorManager.whiteColors,
                        selectedLabelStyle: TextStyleManager.font12RegularWhite,
                        unselectedLabelStyle:
                            TextStyleManager.font14RegularYellowColor,
                        onTap: (value) {
                          context.read<ChangeBottomNavBarIndex>().changeIndex(
                            value,
                          );
                        },
                        items: const [
                          BottomNavigationBarItem(
                            icon: Icon(
                              Icons.home,
                            ),
                            label: " الرئيسية",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.person),
                            label: "ملفي",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.grid_view),
                            label: "المصادر",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.border_color),
                            label: "الحجز",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 23.h,
                  right: 21.w,
                  child: SizedBox(
                    height: 56.h,
                    width: 56.h,
                    child: Image.asset(AppAssets.emergency),
                  ),
                ),
              ],
            ),
            body: context.read<ChangeBottomNavBarIndex>().screens[index],
          );
        },
      ),
    );
  }
}
