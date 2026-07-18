import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pivot/core/utils/app_assets.dart';
import 'package:pivot/core/utils/app_colors.dart';

class AccountInfoCard extends StatelessWidget {
  const AccountInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    // موك داتا جاهزة للاستبدال ببيانات المستخدم الحالية لايف بعدين
    const String name = "مريم علي عيسى";
    const String email = "maria.m@gmail.com";
    const String phone = "+966 55 123 4567";

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
              // 🟢 كونتينر دائري مثالي للأيقونة الـ SVG (تم إزالة الـ borderRadius لمنع الـ crash)
              Container(
                width: 28.w,
                height: 28.w,
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(
                  color: Color(0x1A0052B5),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppAssets.settingsAccountIcon,
                  colorFilter: const ColorFilter.mode(Color(0xFF3B82F6), BlendMode.srcIn),
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                "بيانات الحساب",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildInfoRow("الاسم", name),
          SizedBox(height: 10.h),
          const Divider(color: Color(0xFFE0E0E0), height: 20),
          SizedBox(height: 10.h),
          _buildInfoRow("البريد الإلكتروني", email),
          SizedBox(height: 10.h),

          const Divider(color: Color(0xFFE0E0E0), height: 20),

          SizedBox(height: 10.h),
          _buildInfoRow("رقم الهاتف", phone),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                side: const BorderSide(color: Color(0xFF4496F9)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
              ),
              onPressed: () {},
              icon: SvgPicture.asset(
                AppAssets.settingsEditIcon,
                width: 12.w,
                height: 12.h,
                colorFilter: const ColorFilter.mode(Color(0xFF3B82F6), BlendMode.srcIn),
              ),
              label: Text(
                "تعديل",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10.sp,
                  color: const Color(0xFF0052B5),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.w400 ,fontSize: 8.sp, color: const Color(0xFF6B7280)),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(fontFamily: 'Cairo', fontSize: 10.sp, fontWeight: FontWeight.w500, color: Color(0xFF313131)),
        ),
      ],
    );
  }
}