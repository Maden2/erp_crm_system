import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../manager/full_analytics_cubit.dart';
import '../manager/full_analytics_state.dart';

class SalesChartWidget extends StatefulWidget {
  const SalesChartWidget({super.key});

  @override
  State<SalesChartWidget> createState() => _SalesChartWidgetState();
}

class _SalesChartWidgetState extends State<SalesChartWidget> {
  bool _isSales = true;

  // دالة ذكية لتحويل الـ ISO String إلى اسم اليوم أو صيغة مبسطة (مثال: السبت أو 06-19)
  String _formatChartDate(String isoDate) {
    try {
      final DateTime parsedDate = DateTime.parse(isoDate);
      // لو حابب تعرض أسماء الأيام باللغة العربية
      return DateFormat('EEEE', 'ar').format(parsedDate);
    } catch (_) {
      if (isoDate.contains('T')) {
        final split = isoDate.split('T')[0].split('-');
        if (split.length >= 3) return '${split[1]}-${split[2]}';
      }
      return isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FullAnalyticsCubit, FullAnalyticsState>(
      builder: (context, state) {
        if (state is FullAnalyticsSuccess) {
          final chartData = state.analytics.salesChart.chart;

          if (chartData.isEmpty) return const SizedBox();

          List<FlSpot> spots = [];
          double maxY = 10;

          for (int i = 0; i < chartData.length; i++) {
            final val = _isSales ? chartData[i].revenue : chartData[i].ordersCount.toDouble();
            spots.add(FlSpot(i.toDouble(), val));
            if (val > maxY) maxY = val;
          }

          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.authBgColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('مخطط المبيعات', style: TextStyles.font12darkTextMedium),
                    _buildToggle(),
                  ],
                ),
                SizedBox(height: 22.h),
                SizedBox(
                  height: 180.h,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        getDrawingHorizontalLine: (_) => FlLine(
                          color: const Color(0xFFE2E8F0),
                          strokeWidth: 1,
                          dashArray: [4, 4],
                        ),
                        drawVerticalLine: false,
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index < 0 || index >= chartData.length) return const SizedBox();

                              // 🟢 تطبيق الـ Format النظيف لمنع النصوص الطويلة والمائلة تحت الشارت
                              return Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: Text(
                                  _formatChartDate(chartData[index].date),
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF718EBF),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          curveSmoothness: 0.3,
                          color: AppColors.navSelectedColor,
                          barWidth: 2.5,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.navSelectedColor.withOpacity(0.15),
                                AppColors.navSelectedColor.withOpacity(0.0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                      minX: 0,
                      maxX: spots.length.toDouble() - 1,
                      minY: 0,
                      maxY: maxY * 1.2, // إعطاء مساحة مريحة للمنحنى بالأعلى تمنع هبوطه الحاد بره الكادر
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildToggle() {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(color: AppColors.homeBg, borderRadius: BorderRadius.circular(13.r)),
      child: Row(
        children: [
          _toggleItem('المبيعات', _isSales, () => setState(() => _isSales = true)),
          _toggleItem('الطلبات', !_isSales, () => setState(() => _isSales = false)),
        ],
      ),
    );
  }

  Widget _toggleItem(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.navSelectedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(13.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 10.sp,
            color: isSelected ? AppColors.authBgColor : AppColors.navSelectedColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}