import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pivot/core/utils/app_assets.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../manager/full_analytics_cubit.dart';

class AnalyticsHeader extends StatefulWidget {
  const AnalyticsHeader({super.key});

  @override
  State<AnalyticsHeader> createState() => _AnalyticsHeaderState();
}

class _AnalyticsHeaderState extends State<AnalyticsHeader> {
  String _selected = 'يومي';

  String _mapPeriodToEn(String arabicPeriod) {
    if (arabicPeriod == 'شهري') return 'monthly';
    if (arabicPeriod == 'سنوي') return 'yearly';
    return 'daily';
  }

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
              child: Image.asset(AppAssets.analyticsHeaderBg, fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.h, left: 24.w, right: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
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
                  // 🟢 تعديل الـ Row لضبط المسافات ولم الأزرار باحترافية
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCustomPicker(),

                      // تجميع أزرار الفترات بمسافات ثابتة صغيرة متناسقة
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          _buildPeriodButton('يومي'),
                          SizedBox(width: 8.w),
                          _buildPeriodButton('شهري'),
                          SizedBox(width: 8.w),
                          _buildPeriodButton('سنوي'),
                        ],
                      ),
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
      onTap: () async {
        final DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null && mounted) {
          final String from = picked.start.toIso8601String().split('T')[0];
          final String to = picked.end.toIso8601String().split('T')[0];
          context.read<FullAnalyticsCubit>().getAnalytics(
            period: _mapPeriodToEn(_selected),
            dateFrom: from,
            dateTo: to,
          );
        }
      },
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
              colorFilter: const ColorFilter.mode(AppColors.homeBg, BlendMode.srcIn),
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
            const Icon(Icons.keyboard_arrow_down, color: AppColors.homeBg, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodButton(String period) {
    final bool isSelected = _selected == period;
    return GestureDetector(
      onTap: () {
        setState(() => _selected = period);
        context.read<FullAnalyticsCubit>().getAnalytics(period: _mapPeriodToEn(period));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF2FE) : AppColors.authBgColor,
          borderRadius: BorderRadius.circular(20.r),
          border: isSelected ? Border.all(color: const Color(0xFF0D1B5E), width: 1.5.w) : null,
        ),
        child: Text(
          period,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? const Color(0xFF0D1B5E) : AppColors.primary,
          ),
        ),
      ),
    );
  }
}