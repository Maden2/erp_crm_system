import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import 'package:pivot/core/widgets/custom_app_bar.dart';
import 'package:pivot/features/orders/Presentation/widgets/details/customer_note_box.dart';

import '../../../../core/utils/app_assets.dart';
import '../../domain/entities/order_entity.dart';

import '../widgets/details/customer_info_card.dart';
import '../widgets/details/order_products_card.dart';
import '../widgets/details/order_status_header.dart';
import '../widgets/details/order_summary_card.dart';
import '../widgets/details/shipping_info_card.dart';
import '../widgets/details/payment_info_card.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      appBar: CustomAppBar(
        title: Text(
          "تفاصيل الطلب ${order.orderNumber}",
          style: TextStyles.font20WhiteMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          children: [
            OrderStatusHeader(
              status: order.status,
              date: _formatDate(order.date),
            ),

            SizedBox(height: 16.h),

            CustomerInfoCard(order: order),

            SizedBox(height: 14.h),

            OrderProductsCard(order: order),

            SizedBox(height: 14.h),

            OrderSummaryCard(order: order),

            SizedBox(height: 14.h),

            PaymentInfoCard(order: order),

            SizedBox(height: 14.h),

            ShippingInfoCard(order: order),

            if (order.staffNotes.isNotEmpty) ...[
              SizedBox(height: 14.h),
              CustomerNoteBox(note: order.staffNotes),
            ],
            SizedBox(height: 8.h),

            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}";
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0x1AEF4C53),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("الغاء الطلب", style: TextStyles.font12RedMedium),
            ),
          ),
        ),

        SizedBox(width: 20.w),

        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.navSelectedColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 8.w),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "تحديث حالة الطلب",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: 20.w),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(7.r),
          ),
          child: TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
            ),
            icon: SvgPicture.asset(
              AppAssets.printIcon,
              width: 14.w,
              height: 14.h,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: Text(
              "طباعة الفاتورة",
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12.sp,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
