import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../../domain/entities/live_order_entity.dart';

class OrderCard extends StatelessWidget {
  final LiveOrderEntity order; // 🟢 قراءة الـ Entity الحقيقية الجديدة

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // تحويل الـ HEX المريح بناءً على كود الحالة القادم من السيرفر
    final Color statusColor = _parseTailwindColor(order.statusMeta.color);
    final Color statusBg = _parseTailwindColor(order.statusMeta.bg);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/order-details', arguments: order);
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
                  color: statusColor, // 🟢 اللون يأتي ديناميكيًا من السيرفر
                  width: 4.w,
                ),
              ),
            ),
            padding: EdgeInsets.all(12.w),
            child: Row(
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
                    // 🟢 الـ Badge الديناميكي مستغلين بيانات الباكيند بالكامل
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        order.statusLabel, // الاسم العربي القادم من السيرفر
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey),
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

  // دالة مساعدة سريعة لتحويل مسميات الـ Tailwind لألوان حقيقية في فلاتر
  Color _parseTailwindColor(String tailwindClass) {
    if (tailwindClass.contains('yellow')) return const Color(0xFFD97706);
    if (tailwindClass.contains('blue')) return const Color(0xFF2563EB);
    if (tailwindClass.contains('purple')) return const Color(0xFF7C3AED);
    if (tailwindClass.contains('green') || tailwindClass.contains('emerald')) return const Color(0xFF059669);
    if (tailwindClass.contains('red')) return const Color(0xFFDC2626);
    if (tailwindClass.contains('orange')) return const Color(0xFFEA580C);
    return Colors.grey;
  }
}