import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/latest_support_ticket_entity.dart';

class LatestSupportTicketSection extends StatelessWidget {
  final LatestSupportTicketEntity ticket;

  const LatestSupportTicketSection({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
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

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("تذاكر الدعم الجديدة", style: TextStyles.font12BlackMedium),
              SizedBox(height: 4.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "لديك تذكرة جديدة ",
                          style: TextStyles.font10CharcoalGrayRegular,
                        ),
                        TextSpan(
                          text: "رقم ${ticket.ticketNumber}",
                          style: TextStyles.font10MainBlueRegular,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 6.w),
                  Text(ticket.timeAgo, style: TextStyles.font10CoolGreyRegular),

                  SizedBox(width: 4.w),
                ],
              ),
            ],
          ),

          SizedBox(width: 12.w),
          Icon(Icons.arrow_forward_ios, size: 16.sp, color: Color(0xFF6B7280)),
        ],
      ),
    );
  }
}
