import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../domain/entities/invoice_entity.dart';

class InvoicePaymentSection extends StatelessWidget {
  final InvoiceEntity invoice;

  const InvoicePaymentSection({super.key, required this.invoice});

  String _getPaymentIcon(String methodName) {
    if (methodName.contains("تحويل بنكي")) {
      return AppAssets.bankTransferIcon;
    } else if (methodName.contains("دفع نقدي") || methodName.contains("كاش")) {
      return AppAssets.cashPaymentIcon;
    } else {
      return AppAssets.paymentIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Text(
              "طريقة الدفع",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: const Color(0xFF111827),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                Container(
                  width: 29.w,
                  height: 29.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightBlue.withValues(alpha: 0.1),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      _getPaymentIcon(invoice.paymentMethod.methodName),
                      width: 17.w,
                      height: 17.w,
                      colorFilter: const ColorFilter.mode(
                        AppColors.lightBlue,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice.paymentMethod.methodName,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      invoice.paymentMethod.paymentStatus,
                      style: TextStyles.font10GreyTextRegular,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
