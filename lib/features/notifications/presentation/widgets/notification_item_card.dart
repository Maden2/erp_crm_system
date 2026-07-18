import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../../../../core/utils/app_assets.dart';
import '../../domain/entities/notice_entities.dart';

class NotificationItemCard extends StatelessWidget {
  final NoticeItemEntity notification;
  final VoidCallback? onTap;

  const NotificationItemCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String svgPath;
    Color iconColor;
    Color bgColor;

    // مطابقة الأنواع القادمة من الـ API الحقيقي مباشرة
    switch (notification.type) {
      case "NewOrder":
        svgPath = AppAssets.notificationNewOrder;
        iconColor = const Color(0xFF3B82F6);
        bgColor = const Color(0xFFEFF6FF);
        break;
      case "LowStock":
        svgPath = AppAssets.notificationLowStock;
        iconColor = const Color(0xFFF59E0B);
        bgColor = const Color(0xFFFEF3C7);
        break;
      case "Support":
      case "NewTicket":
        svgPath = AppAssets.notificationSupport;
        iconColor = const Color(0xFF8B5CF6);
        bgColor = const Color(0xFFF5F3FF);
        break;
      case "Sales":
        svgPath = AppAssets.notificationSalesUp;
        iconColor = const Color(0xFF10B981);
        bgColor = const Color(0xFFECFDF5);
        break;
      default:
        svgPath = AppAssets.notificationSystemUpdate;
        iconColor = const Color(0xFF64748B);
        bgColor = const Color(0xFFF1F5F9);
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.authBgColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            // 1️⃣ الأيقونة الدائرية الملونة يمين
            Container(
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: SvgPicture.asset(
                svgPath,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
            SizedBox(width: 12.w),

            // 2️⃣ تفاصيل الإشعار في المنتصف
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    notification.body,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    notification.createdAt.length > 16
                        ? notification.createdAt.substring(0, 16).replaceAll('T', ' ')
                        : notification.createdAt,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 10.sp,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),

            // 3️⃣ النقطة الزرقاء لو الإشعار غير مقروء (شمال الكارت)
            if (!notification.isRead)
              Container(
                width: 7.w,
                height: 7.w,
                margin: EdgeInsets.only(right: 8.w),
                decoration: const BoxDecoration(
                  color: Color(0xFF3B82F6),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}