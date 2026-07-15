import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_styles.dart';

class EmptyCustomersWidget extends StatelessWidget {
  const EmptyCustomersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 60.h),
          Container(
            width: 160.w,
            height: 160.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.group_outlined,
              size: 80.sp,
              color: const Color(0xFF94A3B8).withOpacity(0.4),
            ),
          ),
          SizedBox(height: 32.h),
          Text(
            "لا يوجد عملاء حتى الآن!",
            style: TextStyles.font16graphiteGreyMedium.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            "سيظهر عملاؤك هنا بعد أول طلب يتم إنشاؤه.",
            style: TextStyles.font12DarkGreyRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}