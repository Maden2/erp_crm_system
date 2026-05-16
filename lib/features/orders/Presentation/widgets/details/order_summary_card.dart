import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../domain/entities/order_entity.dart';

class OrderSummaryCard extends StatelessWidget {
  final OrderEntity order;
  const OrderSummaryCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: AppColors.authBgColor, borderRadius: BorderRadius.circular(8.r)),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text("ملخص الطلب",style: TextStyles.font12darkTextMedium,),
          _buildSummaryRow("إجمالي المنتجات", "${order.subTotal} ج.م"),
          _buildSummaryRow("الشحن", "${order.shippingFees} ج.م"),
          _buildSummaryRow("الضريبة (15%)", "${order.tax} ج.م"),

          if (order.discount > 0)
            _buildSummaryRow(
              "الخصم",
              "-${order.discount} ج.م",
              isDiscount: true,
            ),

          const Divider(height: 0.3,color: Color(0xFFE0E0E0),),
          _buildSummaryRow(
            "الإجمالي النهائي",
            "${order.totalAmount} ج.م",
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isTotal = false, bool isDiscount = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13.sp,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount
                  ? const Color(0xFF22C55E)
                  : (isTotal ? const Color(0xFF1E293B) : const Color(0xFF64748B)),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal
                  ? AppColors.primary
                  : (isDiscount ? const Color(0xFF22C55E) : const Color(0xFF1E293B)),
            ),
          ),
        ],
      ),
    );
  }
}