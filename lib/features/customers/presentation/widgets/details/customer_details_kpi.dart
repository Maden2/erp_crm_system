import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';

class CustomerDetailsKpi extends StatelessWidget {
  final int totalOrders;
  final double totalPurchases;
  final double averageOrderValue;

  const CustomerDetailsKpi({
    super.key,
    required this.totalOrders,
    required this.totalPurchases,
    required this.averageOrderValue,
  });

  String _formatNumber(num value) {
    final raw = value.toInt().toString();
    final buffer = StringBuffer();

    for (int i = 0; i < raw.length; i++) {
      final remaining = raw.length - i;
      if (i != 0 && remaining % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(raw[i]);
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16.w,
        12.h,
        16.w,
        14.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildCard(
              title: "عدد الطلبات",
              value: "$totalOrders",
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildCard(
              title: "إجمالي المشتريات",
              value: "${_formatNumber(totalPurchases)} ج.م",
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildCard(
              title: "متوسط قيمة الطلب",
              value: "${_formatNumber(averageOrderValue)} ج.م",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
  }) {
    return Container(
      height: 68.h,
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }
}