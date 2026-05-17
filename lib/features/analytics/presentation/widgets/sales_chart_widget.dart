import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

class SalesChartWidget extends StatefulWidget {
  const SalesChartWidget({super.key});

  @override
  State<SalesChartWidget> createState() => _SalesChartWidgetState();
}

class _SalesChartWidgetState extends State<SalesChartWidget> {
  bool _isSales = true;

  final List<FlSpot> _salesSpots = [
    FlSpot(0, 5.0),
    FlSpot(1, 3.5),
    FlSpot(2, 4.2),
    FlSpot(3, 3.8),
    FlSpot(4, 6.5),
    FlSpot(5, 3.0),
    FlSpot(6, 4.8),
  ];

  final List<FlSpot> _ordersSpots = [
    FlSpot(0, 2.0),
    FlSpot(1, 4.0),
    FlSpot(2, 3.0),
    FlSpot(3, 5.0),
    FlSpot(4, 3.5),
    FlSpot(5, 4.5),
    FlSpot(6, 3.2),
  ];

  final List<String> _days = [
    'الجمعة',
    'الخميس',
    'الأربعاء',
    'الثلاثاء',
    'الاثنين',
    'الأحد',
    'السبت',
  ];

  @override
  Widget build(BuildContext context) {
    final spots = _isSales ? _salesSpots : _ordersSpots;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal:21.w ,vertical:11.h ),
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
              Text(
                'مخطط المبيعات',
                style: TextStyles.font12darkTextMedium
              ),
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
                  drawVerticalLine: true,
                  drawHorizontalLine: true,
                  verticalInterval: 1,
                  horizontalInterval: 2,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: const Color(0xFFE2E8F0),
                    strokeWidth: 1,
                    dashArray: [4, 4],
                  ),
                  getDrawingVerticalLine: (_) => FlLine(
                    color: const Color(0xFFE2E8F0),
                    strokeWidth: 1,
                    dashArray: [4, 4],
                  ),
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
                        if (index < 0 || index >= _days.length) return const SizedBox();
                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            _days[index],
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
                    curveSmoothness: 0.4,
                    color: AppColors.navSelectedColor,
                    barWidth: 2.5,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF1D4ED8).withOpacity(0.18),
                          const Color(0xFF1D4ED8).withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical:5.h ),
      decoration: BoxDecoration(
        color: AppColors.homeBg,
        borderRadius: BorderRadius.circular(13.r),
      ),
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
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
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
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}