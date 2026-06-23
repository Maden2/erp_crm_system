import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_assets.dart';

class EmptyInvoicesView extends StatelessWidget {
  const EmptyInvoicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.emptyInvoicesIcon,
              width: 188.w,
              height: 140.h,
            ),
            SizedBox(height: 24.h),
            Text(
              "لا توجد فواتير حتى الآن!",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xff363A33),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "ستظهر الفواتير تلقائيًا عند إتمام أول طلب.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Color(0xff60655C)),
            ),
          ],
        ),
      ),
    );
  }
}
