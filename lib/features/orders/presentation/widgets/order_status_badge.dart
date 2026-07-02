import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderStatusBadge extends StatelessWidget {
  final String status;
  final bool showDot;

  const OrderStatusBadge({
    super.key,
    required this.status,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _getStatusColor(status);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: showDot ? 10.w : 8.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            CircleAvatar(radius: 3.r, backgroundColor: statusColor),
            SizedBox(width: 6.w),
          ],
          Text(
            status,
            style: TextStyle(
              fontFamily: 'Cairo',
              color: statusColor,
              fontSize: 11.sp,
              fontWeight: showDot ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
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
