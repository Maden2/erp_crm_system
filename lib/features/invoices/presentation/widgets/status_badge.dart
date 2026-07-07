import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final String colorHex;

  const StatusBadge({super.key, required this.label, required this.colorHex});

  @override
  Widget build(BuildContext context) {
    Color baseColor;

    if (colorHex.contains('green')) {
      baseColor = const Color(0xFF16A34A);
    } else if (colorHex.contains('orange')) {
      baseColor = const Color(0xFFEA580C);
    } else if (colorHex.contains('red')) {
      baseColor = const Color(0xFFDC2626);
    } else if (colorHex.contains('blue')) {
      baseColor = const Color(0xFF2563EB);
    } else if (colorHex.contains('purple')) {
      baseColor = const Color(0xFF9333EA);
    } else {
      try {
        final hex = colorHex.replaceAll('#', '');
        baseColor = Color(int.parse("FF$hex", radix: 16));
      } catch (_) {
        baseColor = Colors.grey;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: baseColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: baseColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}