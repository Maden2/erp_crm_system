import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/notification_entity.dart';

class LatestSupportTicketSection extends StatelessWidget {
  final NotificationEntity notification;

  const LatestSupportTicketSection({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    // 🟢 حل سحري لتقصير وقت الـ ISO الطويل عشان م يضربش الـ UI في المساحة الضيقة تحت
    String timeDisplay = notification.createdAt;
    if (timeDisplay.contains('T')) {
      timeDisplay = timeDisplay.split('T')[0]; // بياخد الجزء الأول فقط YYYY-MM-DD
      if (timeDisplay.length > 5) {
        timeDisplay = timeDisplay.substring(5); // بيظهر كـ MM-DD عشان يبقا حجمه متناسق ونظيف
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Container(
            width: 49.w,
            height: 49.h,
            alignment: Alignment.center,
            padding: EdgeInsets.all(12.w),
            decoration: const BoxDecoration(
              color: Color(0xFFF9EED2),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              AppAssets.supportTicketIcon,
              width: 22.w,
              height: 22.h,
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.title, style: TextStyles.font12BlackMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(height: 4.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        notification.body,
                        style: TextStyles.font10CharcoalGrayRegular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    // 🟢 هنا عرضنا الوقت النظيف والمقصوص بدقة
                    Text(timeDisplay, style: TextStyles.font10CoolGreyRegular),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios, size: 16.sp, color: const Color(0xFF6B7280)),
        ],
      ),
    );
  }
}