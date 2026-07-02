import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/profit_entity.dart';

class ProfitsAnalysisChart extends StatelessWidget {
  final List<ChartDataPoint> chartPoints;
  const ProfitsAnalysisChart({super.key, required this.chartPoints});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("تحليل الأداء المالي", style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp, fontWeight: FontWeight.w700, color: const Color(0xff111827))),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildLegendItem("الإيرادات", const Color(0xff1D4ED8)),
              SizedBox(width: 12.w),
              _buildLegendItem("التكاليف", const Color(0xffF43F5E)),
              SizedBox(width: 12.w),
              _buildLegendItem("صافي الربح", const Color(0xff10B981)),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            height: 160.h,
            width: double.infinity,
            color: const Color(0xffFAFAFA),
            child: Center(
              child: Icon(Icons.show_chart, color: const Color(0xff10B981), size: 50.w),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: chartPoints.reversed.map((p) => Text(p.dayName, style: TextStyle(fontFamily: 'Cairo', fontSize: 10.sp, color: const Color(0xff9CA3AF)))).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontFamily: 'Cairo', fontSize: 11.sp, color: const Color(0xff4B5563))),
        SizedBox(width: 4.w),
        Container(width: 8.w, height: 8.h, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      ],
    );
  }
}