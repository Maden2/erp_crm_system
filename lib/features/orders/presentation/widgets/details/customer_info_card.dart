import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pivot/core/utils/app_assets.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

import '../../../domain/entities/live_order_entity.dart';

class CustomerInfoCard extends StatelessWidget {
  final LiveOrderEntity order; // 🟢 تم التحديث للـ Entity الحقيقية

  const CustomerInfoCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return _buildSectionCard("معلومات العميل", [
      _buildDetailRow(AppAssets.profileIcon, "اسم العميل", order.customerName),
      _buildDetailRow(AppAssets.phoneIcon, "رقم الهاتف", order.phoneNumber ?? "لا يوجد رقم هاتف"),
      _buildDetailRow(AppAssets.mailIcon, "البريد الإلكتروني", order.customerEmail),
      _buildDetailRow(
          AppAssets.mapIcon,
          "عنوان الشحن",
          "${order.shippingAddressCity}، ${order.shippingAddressCountry}"
      ),

      // 🟢 عرض ملاحظة العميل القادمة من ريكويست التفاصيل
      if (order.customerNote != null && order.customerNote!.isNotEmpty) ...[
        SizedBox(height: 16.h),
        _buildNoteBox(order.customerNote!),
      ],
    ]);
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
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
          Text(title, style: TextStyles.font12darkTextMedium),
          SizedBox(height: 10.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String assetPath, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            assetPath,
            width: 14.w,
            height: 14.h,
            colorFilter: const ColorFilter.mode(
              Color(0xFF9CA3AF),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 9.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyles.font10GreyTextRegular),
                SizedBox(height: 4.h),
                Text(value, style: TextStyles.font12darkTextMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteBox(String note) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFFEF3C7), width: 1),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            Container(
              width: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFFBBF24),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6.r),
                  bottomRight: Radius.circular(6.r),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AppAssets.noteIcon,
                          width: 14.w,
                          height: 14.h,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFFD97706),
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "ملاحظة العميل",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFD97706),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      note,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 10.sp,
                        color: const Color(0xFF783533),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}