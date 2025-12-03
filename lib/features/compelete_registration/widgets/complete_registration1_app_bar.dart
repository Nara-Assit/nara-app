import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/theming/text_style_manager.dart';

class CompleteRegistration1AppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CompleteRegistration1AppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsetsDirectional.only(end: 25.w),
        child: Row(
          spacing: 12.h,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: .end,
                children: [
                  Text(
                    "اهلا محمد,",
                    style: TextStyleManager.font16MediumBlack,
                  ),
                  Text(
                    "ساعدنا نعرف أكتر عنك",
                    style: TextStyleManager.font14RegularBlack,
                  ),
                ],
              ),
            ),
            Image.asset(AppAssets.imagesUserphoto),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
