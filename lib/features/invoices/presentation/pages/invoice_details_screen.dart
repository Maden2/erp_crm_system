import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/invoice_entity.dart';
import 'package:pivot/core/widgets/custom_app_bar.dart';

import '../widgets/details/invoice_header_card.dart';
import '../widgets/details/invoice_products_section.dart';
import '../widgets/details/invoice_payment_section.dart';
import '../widgets/details/invoice_summary_section.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  final InvoiceEntity invoice;

  const InvoiceDetailsScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      appBar: CustomAppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.authBgColor,
            size: 24.w,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("تفاصيل الفاتورة", style: TextStyles.font20WhiteMedium),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InvoiceHeaderCard(invoice: invoice),
            SizedBox(height: 14.h),

            InvoiceProductsSection(invoice: invoice),
            SizedBox(height: 14.h),

            InvoicePaymentSection(invoice: invoice),
            SizedBox(height: 14.h),

            InvoiceSummarySection(invoice: invoice),
            SizedBox(height: 40.h),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        color: AppColors.authBgColor,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppAssets.downloadPdfIcon,
                  width: 14.w,
                  height: 14.w,
                  colorFilter: ColorFilter.mode(
                    AppColors.greyText,
                    BlendMode.srcIn,
                  ),
                ),

                label: Text(
                  "تحميل PDF",
                  style: TextStyles.font12GrayTextRegular,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEEF0F4),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),

            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppAssets.shareInvoiceIcon,
                  width: 16.w,
                  height: 16.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.greyText,
                    BlendMode.srcIn,
                  ),
                ),

                label: Text("مشاركة", style: TextStyles.font12GrayTextRegular),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffEEF0F4),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
