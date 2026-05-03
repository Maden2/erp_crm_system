import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyHomeState extends StatelessWidget {
  const EmptyHomeState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _ShimmerStatsCard(),
        SizedBox(height: 10.h),
        const _ShimmerStatsCard(),

        SizedBox(height: 24.h),


        Container(
          width: double.infinity,
          height: 220.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFF1F1F1)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.insert_chart_outlined,
                  size: 50.sp, color: Colors.grey[300]),
              SizedBox(height: 12.h),
              Text(
                "لا توجد بيانات مبيعات حالياً",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),

        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF21418B),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              elevation: 0,
            ),
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text(
              "أضف أول منتج لك",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Shimmer Card ───────────────────────────────────────────────────────────

class _ShimmerStatsCard extends StatefulWidget {
  const _ShimmerStatsCard();

  @override
  State<_ShimmerStatsCard> createState() => _ShimmerStatsCardState();
}

class _ShimmerStatsCardState extends State<_ShimmerStatsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _animation = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _shimmerBox({required double width, required double height}) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value, 0),
              colors: const [
                Color(0xFFEEEEEE),
                Color(0xFFF5F5F5),
                Color(0xFFEEEEEE),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 108.h,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                width: 49.w,
                height: 49.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFE3F2FD),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xFF185FA5),
                  size: 22,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'إجمالي مبيعات اليوم',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    SizedBox(height: 6.h),

                    _shimmerBox(width: 80.w, height: 20.h),
                  ],
                ),
              ),
              const Icon(
                Icons.trending_up,
                color: Color(0xFF21418B),
                size: 20,
              ),
            ],
          ),

          _shimmerBox(width: 140.w, height: 12.h),
        ],
      ),
    );
  }
}