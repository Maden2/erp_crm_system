import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pivot/core/utils/app_assets.dart';
import 'package:pivot/core/utils/app_colors.dart';

class SystemConnectionCard extends StatelessWidget {
  const SystemConnectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    // فلاج موك للتحكم في الحالة: true = متصل، false = غير متصل
    const bool isConnected = true;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(
                  color: Color(0x1A0052B5),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppAssets.settingsConnectionIcon,
                  colorFilter: const ColorFilter.mode(Color(0xFF3B82F6), BlendMode.srcIn),
                ),
              ),

              SizedBox(width: 6.w),
              Text(
                "حالة الربط مع النظام",
                style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.w500, color: Color(0xFF111827)),
              ),

              // 🟢 كونتينر دائري مثالي للأيقونة الـ SVG
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isConnected ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: BoxDecoration(
                        color: isConnected ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),

                    SizedBox(width: 4.w),
                    Text(
                      isConnected ? "متصل" : "غير متصل",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: isConnected ? const Color(0xFF17CE32) : const Color(0xFFEF4444),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(width: 6.h,),
              Text(
                "نظام المورد الرئيسي",
                style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w400,fontSize: 9.sp, color: const Color(0xFF6B7280)),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.refresh, size: 8.sp, color: const Color(0xFF6B7280)),

              SizedBox(width: 4.w),
              Text(
                "آخر مزامنة: 2026/01/07 01:45 م",
                style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.w400 ,fontSize: 7.sp, color: const Color(0xFF6B7280)),
              ),

            ],
          ),
        ],
      ),
    );
  }
}