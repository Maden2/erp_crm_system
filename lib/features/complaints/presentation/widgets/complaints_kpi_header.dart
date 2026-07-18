import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';

class ComplaintsKpiHeader extends StatelessWidget {
  final int total;
  final int open;
  final int closed;
  final String rate;

  const ComplaintsKpiHeader({
    super.key,
    required this.total,
    required this.open,
    required this.closed,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          _buildKpiCard("إجمالي الشكاوي", "$total"),
          SizedBox(width: 6.w),
          _buildKpiCard("مفتوحة", "$open"),
          SizedBox(width: 6.w),
          _buildKpiCard("مغلقة", "$closed"),
          SizedBox(width: 6.w),
          _buildKpiCard("نسبة الإغلاق", rate.contains("%") ? rate : "$rate%"),
        ],
      ),
    );
  }

  Widget _buildKpiCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.authBgColor,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 10.sp,
                color: const Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}