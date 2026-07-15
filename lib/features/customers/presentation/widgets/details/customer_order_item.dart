import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../domain/entities/client_entities.dart'; // 🟢 الاستيراد من الكيان الجديد المعزول

class CustomerOrderItem extends StatelessWidget {
  final ClientOrderHistoryEntity order; // 🟢 استخدام الـ Entity الجديد لطلب السيرفر

  const CustomerOrderItem({super.key, required this.order});

  String _formatNumber(num value) {
    final raw = value.toInt().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < raw.length; i++) {
      final remaining = raw.length - i;
      if (i != 0 && remaining % 3 == 0) buffer.write(',');
      buffer.write(raw[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = order.statusLabel == "تم التوصيل" || order.statusLabel == "تم";

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: const BoxDecoration(
              color: Color(0xFF2563EB),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: AppColors.authBgColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.orderId, style: TextStyles.font8slateGrayRegular), // 🟢 ربط الـ orderId الجديد
                      SizedBox(height: 6.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: isCompleted ? const Color(0xFFEFF6FF) : const Color(0xFFFFFBEB),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          order.statusLabel,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 10.sp,
                            color: isCompleted ? const Color(0xFF2563EB) : const Color(0xFFD97706),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.date, style: TextStyles.font8slateGrayRegular),
                      SizedBox(height: 4.h),
                      Text(
                        "${_formatNumber(order.amount)} ج.م",
                        style: TextStyles.font10darkTextRegular,
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
}