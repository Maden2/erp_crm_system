import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pivot/core/utils/app_assets.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

import '../../../domain/entities/live_order_entity.dart';

class ShippingInfoCard extends StatelessWidget {
  final LiveOrderEntity order; // 🟢 تم التحديث للـ Entity الحقيقية

  const ShippingInfoCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("الشحن", style: TextStyles.font12darkTextMedium),

          _buildShippingRow(AppAssets.shippingIcon, "مدينة الشحن", order.shippingAddressCity),
          _buildShippingRow(AppAssets.trackingIcon, "الدولة", order.shippingAddressCountry),
          _buildShippingRow(
            AppAssets.mapIcon,
            "حالة الشحنة لايف",
            order.statusLabel,
            valueColor: AppColors.primary,
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB).withOpacity(0.5),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.mapIcon,
                  width: 14.w,
                  height: 14.h,
                  colorFilter: const ColorFilter.mode(Color(0xFF111827), BlendMode.srcIn),
                ),
                SizedBox(width: 4.w),
                Text("تتبع الشحنة", style: TextStyles.font12darkTextMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingRow(String assetPath, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(assetPath, width: 14.w, height: 14.h, colorFilter: const ColorFilter.mode(Color(0xFF9CA3AF), BlendMode.srcIn)),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontFamily: 'Cairo', fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xFF6B7280))),
                SizedBox(height: 4.h),
                Text(value, style: TextStyles.font12darkTextMedium.copyWith(color: valueColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}