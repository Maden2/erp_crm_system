import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../../domain/entities/order_entity.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
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
                  color: _getStatusColor(order.status),
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
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 10.sp,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      order.orderNumber,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 11.sp,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Text(
                      order.customerName,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        color: const Color(0xFF6B7280),
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Text(
                      _formatDate(order.date),
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 9.sp,
                        color: const Color(0xFF848688),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      "عدد العناصر: ${order.itemsCount} منتج",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 10.sp,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "الإجمالي: ${order.totalAmount} ج.م",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                        color: const Color(0xFF313131),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    _buildStatusBadge(order.status),

                    SizedBox(height: 40.h),

                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14.sp,
                      color: Colors.grey,
                    ),
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
    return "${date.day} يناير ${date.year} - ${date.hour}:${date.minute}";
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor = _getStatusColor(status).withOpacity(0.1);
    Color textColor = _getStatusColor(status);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "جديد":
        return const Color(0xFF0052B5);

      case "قيد الشحن":
        return const Color(0xFFFBBF24);

      case "تم التسليم":
        return const Color(0xFF00B69B);

      case "ملغى":
        return const Color(0xFFEF4C53);

      default:
        return Colors.grey;
    }
  }
}
