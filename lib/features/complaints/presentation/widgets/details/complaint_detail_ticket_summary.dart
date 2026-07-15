import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';

class ComplaintDetailTicketSummary extends StatelessWidget {
  final String orderNumber;
  final String productName;
  final String orderDate;

  const ComplaintDetailTicketSummary({
    super.key,
    required this.orderNumber,
    required this.productName,
    required this.orderDate,
  });

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
          Text(
            "ملخص التذكرة",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF111827),
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow("رقم الطلب", orderNumber),
          const Divider(color: Color(0xFFF1F5F9), height: 24),
          _buildDetailRow("المنتج", productName),
          const Divider(color: Color(0xFFF1F5F9), height: 24),
          _buildDetailRow("تاريخ الطلب", orderDate),
        ],
      ),
    );
  }

  // 🟢 اللابل فوق، والقيمة تحته في سطر منفصل
  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12.sp,
            color: const Color(0xFF6B7280),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          textAlign: TextAlign.right,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}