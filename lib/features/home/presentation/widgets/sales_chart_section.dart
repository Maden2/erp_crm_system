import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../domain/entities/dashboard_chart_point_entity.dart';
import '../manager/dashboard_chart_cubit.dart';

class SalesChartSection extends StatelessWidget {
  final List<DashboardChartPointEntity> chartData;
  final String selectedFilter; // دي اللّي هتيجي من الـ API زي "daily" أو "weekly"

  const SalesChartSection({
    super.key,
    required this.chartData,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterBar(context),
          SizedBox(height: 20.h),
          Text("مخطط المبيعات", style: TextStyles.font12BlackMedium),
          SizedBox(height: 13.h),
          AspectRatio(
            aspectRatio: 1.7,
            child: chartData.isEmpty
                ? const Center(child: Text("لا توجد بيانات مبيعات حالياً"))
                : LineChart(_mainData()),
          ),
        ],
      ),
    );
  }

  LineChartData _mainData() {
    final data = chartData;
    if (data.isEmpty) return LineChartData();

    final maxY = data.map((e) => e.revenue.toDouble()).reduce((a, b) => a > b ? a : b);
    final roundedMax = maxY == 0 ? 1000.0 : ((maxY / 1000).ceil() * 1000).toDouble();

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: roundedMax / 5,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) => FlLine(color: const Color(0xFFCBD5E1), strokeWidth: 1),
        getDrawingVerticalLine: (value) => FlLine(color: const Color(0xFFCBD5E1), strokeWidth: 1),
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: roundedMax / 5,
            reservedSize: 36.w,
            getTitlesWidget: (value, meta) {
              if (value == 0) return const SizedBox();
              final label = value >= 1000 ? '${(value / 1000).toStringAsFixed(0)}K' : value.toInt().toString();
              return Text(label, style: TextStyles.font10BlackMedium);
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 28.h,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < 0 || index >= data.length || index.toDouble() != value) {
                return const SizedBox();
              }

              // 🟢 بناخد التاريخ زي ما هو جاي "2026-05-09" ونعرض اليوم والشهر بس (05-09) عشان الشياكة والمساحة
              String rawDay = data[index].day; // بتقرأ الـ key "day" المظبوط من الـ Swagger
              String cleanDay = rawDay;
              if (rawDay.contains('T')) {
                cleanDay = rawDay.split('T')[0];
              }
              if (cleanDay.length > 5) {
                cleanDay = cleanDay.substring(5); // بتاخد الـ MM-DD
              }

              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 8.h,
                child: Text(
                  cleanDay,
                  style: TextStyles.font10BlackMedium.copyWith(fontSize: 10.sp),
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: -0.5,
      maxX: data.length.toDouble() - 0.5,
      minY: 0,
      maxY: roundedMax,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            data.length,
                (i) => FlSpot(i.toDouble(), data[i].revenue.toDouble()),
          ),
          isCurved: true,
          color: const Color(0xFF1E4AB0),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
              radius: 4,
              color: const Color(0xFF1E4AB0),
              strokeWidth: 0,
            ),
          ),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    // 1️⃣ الفلاتر المعروضة في الفيجما بنفس الترتيب والمسافات بتاعتك الأصلية
    final uiFilters = ["يومي", "أسبوعي", "شهري"];

    // 2️⃣ القاموس السحري اللّي بيترجم الحروف العربي للـ Values اللّي الباك-إند طالبها بالملي (daily, weekly, monthly)
    final Map<String, String> translationToBackend = {
      "يومي": "daily",
      "أسبوعي": "weekly",
      "شهري": "monthly",
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // بيوزعهم بانتظام زي الفيجما وكودك القديم
      children: uiFilters.reversed.map((filterName) {

        final backendValue = translationToBackend[filterName] ?? "daily";
        final isSelected = backendValue == selectedFilter;

        return GestureDetector(
          onTap: () {
            // 🔥 بنبعت للباك إند الكلمة الرسمية الموثقة في الـ Swagger
            context.read<DashboardChartCubit>().loadDashboardChart(period: backendValue);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFEFF2FE) : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              filterName, // بيعرض "يومي"، "أسبوعي"، "شهري"
              style: TextStyle(
                color: isSelected ? AppColors.blackColor : Colors.grey,
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}