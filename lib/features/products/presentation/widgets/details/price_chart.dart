import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_styles.dart';

class PriceChart extends StatelessWidget {
  final List<double> data;

  const PriceChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<String> days = ['س', 'ح', 'ن', 'ث', 'ر', 'خ', 'ج'];
    final int totalSales = data.isNotEmpty
        ? data.reduce((a, b) => a + b).toInt()
        : 0;

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "مبيعات آخر 7 أيام",
                  style: TextStyles.font14lightGrayTextRegular
                ),
                SizedBox(height: 4.h),
                Text(
                  "$totalSales",
                  style: TextStyles.font16lightBlueMedium
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 83.h,
                width: 169.w,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: _LineChartPainter(data: data),
                ),
              ),
              SizedBox(
                width: 169.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: days
                      .map(
                        (day) => Text(
                          day,
                          style: TextStyles.font12lightGrayTextRegular
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> data;

  _LineChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final double realMax = data.reduce((a, b) => a > b ? a : b);
    final double realMin = data.reduce((a, b) => a < b ? a : b);
    final double margin = (realMax - realMin) == 0
        ? realMax * 0.2
        : (realMax - realMin) * 0.2;
    final double maxVal = realMax + margin;
    final double minVal = realMin - margin;
    final double range = (maxVal - minVal) == 0 ? 1 : maxVal - minVal;

    final List<Offset> points = [];
    for (int i = 0; i < data.length; i++) {
      final double x = i / (data.length - 1) * size.width;
      final double y = size.height - ((data[i] - minVal) / range) * size.height;
      points.add(Offset(x, y));
    }

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF0052B5),
          Color(0xFF6999D5),
          Color(0xFF76A6E2),
          Color(0xFFEFF2FE),
        ],
        stops: [0.1, 0.4, 0.7, 0.9],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(linePath, paint);

    for (final point in points) {
      canvas.drawCircle(point, 5.5, Paint()..color = Colors.white);
      canvas.drawCircle(point, 4.8, Paint()..color = const Color(0xFF2563EB));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
