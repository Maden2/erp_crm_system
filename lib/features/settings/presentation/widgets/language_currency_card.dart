import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pivot/core/utils/app_assets.dart';
import 'package:pivot/core/utils/app_colors.dart';

class LanguageCurrencyCard extends StatelessWidget {
  const LanguageCurrencyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
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
                  AppAssets.settingsLanguageIcon,
                  colorFilter: const ColorFilter.mode(Color(0xFF3B82F6), BlendMode.srcIn),
                ),
              ),

              SizedBox(width: 8.w),
              Text(
                "اللغة والعملة",
                style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.w500, color: Color(0xFF111827)),
              ),

            ],
          ),
          SizedBox(height: 12.h),
          _buildSelectionRow("اللغة", "العربية", Icons.language_outlined),
          const Divider(color: Color(0xFFE0E0E0), height: 20),
          _buildSelectionRow("العملة", "ج.م", Icons.sync_outlined),
        ],
      ),
    );
  }

  Widget _buildSelectionRow(String label, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.w400 ,fontSize: 9.sp, color: const Color(0xFF6B7280)),
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(fontFamily: 'Cairo', fontSize: 10.sp, fontWeight: FontWeight.w400, color: Color(0xFF313131)),
            ),

            SizedBox(width: 2.w),
            Icon(icon, size: 11.sp, color: const Color(0xFF9CA3AF)),

          ],
        ),

      ],
    );
  }
}