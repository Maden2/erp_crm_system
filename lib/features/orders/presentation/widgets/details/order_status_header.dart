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
    // قراءة الألوان الديناميكية من الباكيند علطول
    final Color statusColor = _parseTailwindColor(order.statusMeta.color);
    final Color statusBg = _parseTailwindColor(order.statusMeta.bg);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 🟢 بناء الـ Badge الحقيقي المباشر من داتا السيرفر
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
                order.statusLabel,
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

  Color _parseTailwindColor(String tailwindClass) {
    if (tailwindClass.contains('yellow')) return const Color(0xFFD97706);
    if (tailwindClass.contains('blue')) return const Color(0xFF2563EB);
    if (tailwindClass.contains('purple')) return const Color(0xFF7C3AED);
    if (tailwindClass.contains('green') || tailwindClass.contains('emerald')) return const Color(0xFF059669);
    if (tailwindClass.contains('red')) return const Color(0xFFDC2626);
    if (tailwindClass.contains('orange')) return const Color(0xFFEA580C);
    return Colors.grey;
  }
}