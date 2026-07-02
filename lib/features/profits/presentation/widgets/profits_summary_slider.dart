import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/profit_entity.dart';

class ProfitsSummarySlider extends StatelessWidget {
  final List<ProfitSummaryEntity> summaries;
  const ProfitsSummarySlider({super.key, required this.summaries});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true, // 💡 بدل textDirection عشان العناصر تبدأ من اليمين للشمال
        itemCount: summaries.length,
        itemBuilder: (context, index) {
          final item = summaries[index];
          return Container(
            width: 170.w,
            margin: EdgeInsets.only(left: 12.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: item.isPositive ? const Color(0xffE6F4EA) : const Color(0xffFCE8E6),
                  radius: 20.r,
                  child: Icon(
                    item.isPositive ? Icons.trending_up : Icons.trending_down,
                    color: item.isPositive ? const Color(0xff137333) : const Color(0xffC5221F),
                    size: 20.w,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item.title, style: TextStyle(fontFamily: 'Cairo', color: const Color(0xff6B7280), fontSize: 11.sp)),
                    SizedBox(height: 4.h),
                    Text(
                      "${item.value.toStringAsFixed(0)} ج.م",
                      style: TextStyle(fontFamily: 'Cairo', color: const Color(0xff111827), fontSize: 15.sp, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}