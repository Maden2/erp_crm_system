import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_styles.dart';

import '../../../../core/utils/app_assets.dart';

class EmptyOrdersWidget extends StatelessWidget {
  const EmptyOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.emptyOrdersIcon,
            width: 200.w,
            height: 200.h,
          ),
          SizedBox(height: 24.h),
          Text(
            "قائمة الطلبات فارغة!ً",
            style: TextStyles.font20DarkGreyMedium
          ),
          SizedBox(height: 12.h),
          Text(
            "بانتظار أول طلب ليظهر في لوحة التحكم.",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}