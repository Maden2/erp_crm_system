import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../../domain/entities/live_order_entity.dart';
import '../manager/live_orders_cubit.dart';
import '../pages/order_details_page.dart';

class OrderCard extends StatelessWidget {
  final LiveOrderEntity order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // 🟢 تفرقة صريحة بين لون النص ولون الخلفية
    final Color statusColor = _parseTailwindColor(order.statusMeta.color, isText: true);
    final Color statusBg = _parseTailwindColor(order.statusMeta.bg, isText: false);

    return GestureDetector(
      onTap: () {
        // 🟢 تمرير نفس الـ Cubit الحالي لشاشة التفاصيل وسحب المنتجات لايف
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (blocContext) => BlocProvider.value(
              value: context.read<LiveOrdersCubit>()..getLiveOrderDetails(orderId: order.id),
              child: OrderDetailsPage(order: order),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        decoration: BoxDecoration(
          color: AppColors.authBgColor,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: statusColor,
                  width: 4.w,
                ),
              ),
            ),
            padding: EdgeInsets.all(12.w),
            child: Row(
              textDirection: TextDirection.rtl, // دعم الاتجاه العربي
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "طلب",
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 10.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      order.orderNumber,
                      style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 11.sp, color: Colors.black),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      order.customerName,
                      style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w400, fontSize: 10.sp, color: const Color(0xFF6B7280)),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      _formatDate(order.orderDate),
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 9.sp, color: const Color(0xFF848688)),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "عدد العناصر: ${order.itemCount} منتج",
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 10.sp, color: const Color(0xFF6B7280)),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "الإجمالي: ${order.totalAmount} ج.م",
                      style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w500, fontSize: 11.sp, color: const Color(0xFF313131)),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        order.statusLabel.isNotEmpty ? order.statusLabel : "قيد الانتظار",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: statusColor, // النص الحين بلون غامق صريح هيظهر فوق الخلفية الفاتحة
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Icon(Icons.arrow_back_ios, size: 14.sp, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}";
  }

  // 🟢 دالة ذكية ومعدلة تفصل بين درجات النص الغامقة والخلفيات الفاتحة الخفيفة
  Color _parseTailwindColor(String tailwindClass, {required bool isText}) {
    if (tailwindClass.contains('yellow')) {
      return isText ? const Color(0xFFD97706) : const Color(0xFFFEF3C7); // نص برتقالي غامق فوق خلفية صفراء فاتحة جداً
    }
    if (tailwindClass.contains('blue')) {
      return isText ? const Color(0xFF2563EB) : const Color(0xFFDBEAFE);
    }
    if (tailwindClass.contains('purple')) {
      return isText ? const Color(0xFF7C3AED) : const Color(0xFFF3E8FF);
    }
    if (tailwindClass.contains('green') || tailwindClass.contains('emerald')) {
      return isText ? const Color(0xFF059669) : const Color(0xFFD1FAE5);
    }
    if (tailwindClass.contains('red')) {
      return isText ? const Color(0xFFDC2626) : const Color(0xFFFEE2E2); // نص أحمر غامق فوق خلفية حمراء فاتحة
    }
    if (tailwindClass.contains('orange')) {
      return isText ? const Color(0xFFEA580C) : const Color(0xFFFFEDD5);
    }
    return Colors.grey;
  }
}