import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../domain/entities/live_order_entity.dart';

class OrderStatusHeader extends StatelessWidget {
  final LiveOrderEntity order; // 🟢 قراءة الـ Entity الحقيقية كاملة
  final String date;

  const OrderStatusHeader({
    super.key,
    required this.order,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    // 🟢 قراءة الألوان الديناميكية مع تفعيل الفصل بين النص والخلفية
    final Color statusColor = _parseTailwindColor(order.statusMeta.color, isText: true);
    final Color statusBg = _parseTailwindColor(order.statusMeta.bg, isText: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 🟢 بناء الـ Badge الحقيقي المباشر من داتا السيرفر بعد حل مشكلة اللون السادة
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: statusBg,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 3.r, backgroundColor: statusColor),
              SizedBox(width: 6.w),
              Text(
                order.statusLabel.isNotEmpty ? order.statusLabel : "قيد الانتظار",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: statusColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        Row(
          children: [
            SvgPicture.asset(
              AppAssets.dateIcon,
              width: 12.w,
              height: 12.h,
              colorFilter: const ColorFilter.mode(
                AppColors.greyText,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 4.w),
            Text(date, style: TextStyles.font10GreyTextRegular),
          ],
        ),
      ],
    );
  }

  // 🟢 الدالة الذكية الجديدة للفصل بين درجات الألوان (الخط غامق والخلفية فاتحة)
  Color _parseTailwindColor(String tailwindClass, {required bool isText}) {
    if (tailwindClass.contains('yellow')) {
      return isText ? const Color(0xFFD97706) : const Color(0xFFFEF3C7);
    }
    if (tailwindClass.contains('blue')) {
      return isText ? const Color(0xFF2563EB) : const Color(0xFFDBEAFE);
    }
    if (tailwindClass.contains('purple')) {
      return isText ? const Color(0xFF7C3AED) : const Color(0xFFF3F0FF);
    }
    if (tailwindClass.contains('green') || tailwindClass.contains('emerald')) {
      return isText ? const Color(0xFF059669) : const Color(0xFFE6F4EA);
    }
    if (tailwindClass.contains('red')) {
      return isText ? const Color(0xFFDC2626) : const Color(0xFFFCE8E6);
    }
    if (tailwindClass.contains('orange')) {
      return isText ? const Color(0xFFEA580C) : const Color(0xFFFFEAD2);
    }
    return Colors.grey;
  }
}