import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/profit_entity.dart';

class OperationalCostsGrid extends StatelessWidget {
  final List<OperationalCostEntity> costs;

  const OperationalCostsGrid({super.key, required this.costs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "التكاليف التشغيلية",
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff111827),
          ),
        ),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.6,
          ),
          itemCount: costs.length,
          itemBuilder: (context, index) {
            final cost = costs[index];
            return Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.payment,
                    color: const Color(0xff0D256F),
                    size: 20.w,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    cost.title,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11.sp,
                      color: const Color(0xff6B7280),
                    ),
                  ),
                  Text(
                    "${cost.amount.toStringAsFixed(0)} ج.م",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff111827),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
