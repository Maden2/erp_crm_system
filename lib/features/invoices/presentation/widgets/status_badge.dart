import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../../domain/entities/invoice_entity.dart';

class StatusBadge extends StatelessWidget {
  final InvoiceStatus status;
  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String text;

    switch (status) {
      case InvoiceStatus.paid:
        bgColor = AppColors.lightBlue.withValues(alpha: 0.1);
        textColor = AppColors.lightBlue;
        text = "مدفوعة";
        break;
      case InvoiceStatus.unpaid:
        bgColor = const Color(0xffCF90351A).withValues(alpha: 0.1);
        textColor = const Color(0xffA16207);
        text = "غير مدفوع";
        break;
      case InvoiceStatus.canceled:
        bgColor = AppColors.redColor.withValues(alpha: 0.1);
        textColor = AppColors.redColor;
        text = "ملغاة";
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
