import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../domain/entities/live_order_entity.dart';

class PaymentInfoCard extends StatelessWidget {
  final LiveOrderEntity order; // 🟢 تم التحديث للـ Entity الحقيقية

  const PaymentInfoCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final bool isOrderCancelled = order.status == 4; // الرمز 4 يعني ملغي
    final String displayPaymentStatus = isOrderCancelled ? "فشل الدفع" : "تمت العملية";
    final Color statusColor = isOrderCancelled ? const Color(0xFFEF4444) : const Color(0xFF47B881);

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
          Text("الدفع", style: TextStyles.font12darkTextMedium),
          SizedBox(height: 18.h),

          // وسيلة الدفع لايف من السيرفر (Cash / Visa)
          _buildInfoRow(
            icon: SvgPicture.asset(AppAssets.paymentIcon, width: 14.w, height: 14.h, colorFilter: const ColorFilter.mode(Color(0xFF9CA3AF), BlendMode.srcIn)),
            title: "وسيلة الدفع",
            value: order.paymentMethod,
          ),
          SizedBox(height: 14.h),

          // حالة الدفع
          _buildInfoRow(
            icon: SvgPicture.asset(
              AppAssets.successIcon,
              width: 14.w,
              height: 14.h,
              colorFilter: ColorFilter.mode(statusColor, BlendMode.srcIn),
            ),
            title: "حالة الدفع",
            value: displayPaymentStatus,
            valueColor: statusColor,
          ),
          SizedBox(height: 14.h),

          // رقم الطلب كمرجع للفاتورة
          _buildInfoRow(
            icon: SvgPicture.asset(AppAssets.invoiceIcon, width: 14.w, height: 14.h, colorFilter: const ColorFilter.mode(Color(0xFF9CA3AF), BlendMode.srcIn)),
            title: "رقم الفاتورة المرجعي",
            value: order.orderNumber,
          ),
          SizedBox(height: 14.h),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required Widget icon, required String title, required String value, Color? valueColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        SizedBox(width: 6.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyles.font10GreyTextRegular),
            SizedBox(height: 4.h),
            Text(value, textDirection: TextDirection.rtl, style: TextStyles.font12darkTextMedium.copyWith(color: valueColor)),
          ],
        ),
      ],
    );
  }
}