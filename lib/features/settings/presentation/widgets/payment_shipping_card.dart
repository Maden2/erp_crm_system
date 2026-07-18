import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pivot/core/utils/app_assets.dart';
import 'package:pivot/core/utils/app_colors.dart';

class PaymentShippingCard extends StatelessWidget {
  const PaymentShippingCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                  AppAssets.paymentIcon,
                  colorFilter: const ColorFilter.mode(Color(0xFF3B82F6), BlendMode.srcIn),
                ),
              ),

              SizedBox(width: 8.w),
              Text(
                "الدفع والشحن",
                style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.w500, color: Color(0xFF111827)),
              ),

              // 🟢 كونتينر دائري مثالي للأيقونة الـ SVG
            ],
          ),
          SizedBox(height: 12.h),
          _buildRow("بوابات الدفع المفعلة", "3 خدمات"),
          const Divider(color: Color(0xFFE0E0E0), height: 20),
          _buildRow("طرق الشحن المتاحة", "5 شركات"),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w400,fontSize: 9.sp, color: const Color(0xFF6B7280)),
        ),

        Text(
          count,
          style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.w400 ,fontSize: 9.sp, color: const Color(0xFF6B7280)),
        ),
      ],
    );
  }
}