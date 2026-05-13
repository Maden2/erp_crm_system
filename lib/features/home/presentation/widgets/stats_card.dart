import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

import '../../../../core/utils/app_assets.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String percentage;
  final String subTitlePrefix;
  final String subTitleSuffix;
  final String icon;
  final Color iconBgColor;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.subTitlePrefix,
    required this.subTitleSuffix,
    required this.icon,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 255.w,
      height: 108.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.statsCardBg,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 49.w,
                height: 49.h,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    icon,
                    width: 28.w,
                    height: 28.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyles.font14GreyBold.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      value,
                      style: TextStyles.font16BlackBold
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Image.asset(
                AppAssets.salesIcon,
                width: 15.sp,
                height: 15.sp,
                color: const Color(0xFF0052B5),
              ),

              SizedBox(width: 4.w),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.charcoalGray,
                    ),
                    children: [
                      TextSpan(text: subTitlePrefix),
                      TextSpan(
                        text: percentage,
                        style: TextStyle(
                          color: const Color(0xFF4170F1),
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp,
                        ),
                      ),
                      TextSpan(text: subTitleSuffix),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}