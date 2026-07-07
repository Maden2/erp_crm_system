import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../domain/entities/full_invoice_entities.dart';
import '../status_badge.dart';

class InvoiceHeaderCard extends StatelessWidget {
  final FullInvoiceDetailEntity invoice;

  const InvoiceHeaderCard({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "رقم الفاتورة",
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                  fontSize: 8.sp,
                ),
              ),
              Text(invoice.invoiceNumber, style: TextStyles.font12BlackMedium),
            ],
          ),
          StatusBadge(
            label: invoice.statusLabel,
            colorHex: invoice.statusBadge,
          ),
        ],
      ),
    );
  }
}