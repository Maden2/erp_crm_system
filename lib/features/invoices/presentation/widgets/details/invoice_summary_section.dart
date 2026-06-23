import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../domain/entities/invoice_entity.dart';

class InvoiceSummarySection extends StatelessWidget {
  final InvoiceEntity invoice;

  const InvoiceSummarySection({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          _buildPriceRow("المجموع قبل الضريبة", invoice.subTotal),
          Divider(color: Colors.grey.shade100, height: 24.h),
          _buildPriceRow("الضريبة (15%)", invoice.tax),
          Divider(color: Colors.grey.shade100, height: 24.h),
          _buildPriceRow(
            "الإجمالي النهائي",
            invoice.totalAmount,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? AppColors.blackColor : AppColors.greyText,
            fontWeight: isTotal ? FontWeight.w500 : FontWeight.w400,
            fontSize: isTotal ? 11.sp : 10.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            fontSize: isTotal ? 11.sp : 10.sp,
            color: isTotal ? AppColors.lightBlue : AppColors.mediumGray,
          ),
        ),
      ],
    );
  }
}
