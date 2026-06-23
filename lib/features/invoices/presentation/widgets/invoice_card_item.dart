import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../domain/entities/invoice_entity.dart';
import 'status_badge.dart';
import '../pages/invoice_details_screen.dart';

class InvoiceCardItem extends StatelessWidget {
  final InvoiceEntity invoice;

  const InvoiceCardItem({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InvoiceDetailsScreen(invoice: invoice),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        invoice.invoiceNumber,
                        style: TextStyles.font12BlackMedium,
                      ),

                      SizedBox(width: 8.w),
                      StatusBadge(status: invoice.status),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    invoice.date,
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "الإجمالي:",
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(width: 4.w),
                  Text(
                    invoice.totalAmount,
                    style: TextStyles.font10BlackMedium,
                  ),
                ],
              ),
              SizedBox(width: 10.w),

              Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
