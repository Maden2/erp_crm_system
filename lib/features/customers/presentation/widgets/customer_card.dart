import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../domain/entities/customer_entities.dart';

class CustomerCard extends StatelessWidget {
  final CustomerItemEntity customer;
  final VoidCallback onTap;

  const CustomerCard({super.key, required this.customer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final String initials = customer.name.split(' ').take(2).map((e) => e[0]).join(' ');

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Row(
            textDirection: TextDirection.ltr,
            children: [
              Icon(Icons.keyboard_arrow_left, color: Colors.grey[400], size: 20.sp),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customer.name, style: TextStyles.font12mediumGrayMedium),
                  SizedBox(height: 4.h),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text("عدد الطلبات: ${customer.orderCount}", style: TextStyles.font10slateGrayRegular),
                      SizedBox(width: 12.w),
                      Text("إجمالي الإنفاق: ${customer.totalSpending.toInt()} ج.م", style: TextStyles.font10slateGrayRegular),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 8.w),
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: const Color(0x3D0052B5),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFDBEAFE)),
                ),
                alignment: Alignment.center,
                child: customer.logoUrl != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    customer.logoUrl!,
                    width: 44.w,
                    height: 44.w,
                    fit: BoxFit.cover,
                  ),
                )
                    : Text(
                  initials,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13.sp,
                    color: const Color(0xFF1E4AB0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),            ],
          ),
        ),
      ),
    );
  }
}