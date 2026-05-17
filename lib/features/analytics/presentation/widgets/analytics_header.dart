import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pivot/core/utils/app_assets.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

class AnalyticsHeader extends StatefulWidget {
  const AnalyticsHeader({super.key});

  @override
  State<AnalyticsHeader> createState() => _AnalyticsHeaderState();
}

class _AnalyticsHeaderState extends State<AnalyticsHeader> {
  String _selected = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: const Color(0xFF0D1B5E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
              child: Image.asset(
                AppAssets.analyticsHeaderBg,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 16.h,
                left: 24.w,
                right: 24.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 4.h,
                    ),
                    child: const Text(
                      'التحليلات',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Color(0xFFEFF2FE),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    textDirection: TextDirection.rtl,
                    children: [
                      _buildCustomPicker(),

                      ...[
                        'يومي',
                        'شهري',
                        'سنوي',
                      ].map((period) => _buildPeriodButton(period)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomPicker() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(width: 1.w, color: AppColors.homeBg),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppAssets.dateIcon,
              width: 16,
              height: 16,
              colorFilter: const ColorFilter.mode(
                AppColors.homeBg,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 4.w),
            const Text(
              'نطاق مخصص',
              style: TextStyle(
                color: Color(0xFFEFF2FE),
                fontSize: 10,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4.w),

            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.homeBg,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodButton(String period) {
    final bool isSelected = _selected == period;
    return GestureDetector(
      onTap: () => setState(() => _selected = period),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.authBgColor,
          borderRadius: BorderRadius.circular(20.r),
          border: isSelected
              ? Border.all(color: const Color(0xFF0D1B5E), width: 1.5.w)
              : null,
        ),
        child: Text(period, style: TextStyles.font12PrimaryRegular),
      ),
    );
  }
}
