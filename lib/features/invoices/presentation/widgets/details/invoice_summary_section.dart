import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../domain/entities/full_invoice_entities.dart';

class InvoiceSummarySection extends StatelessWidget {
  final FullInvoiceDetailEntity invoice;

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
          _buildPriceRow("المجموع قبل الضريبة", "${invoice.financials.subTotal.toStringAsFixed(2)} EGP"),
          Divider(color: Colors.grey.shade100, height: 24.h),
          _buildPriceRow("الضريبة (${(invoice.financials.taxRate * 100).toInt()}%)", "${invoice.financials.taxAmount.toStringAsFixed(2)} EGP"),
          Divider(color: Colors.grey.shade100, height: 24.h),
          _buildPriceRow(
            "الإجمالي النهائي",
            "${invoice.financials.grandTotal.toStringAsFixed(2)} EGP",
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