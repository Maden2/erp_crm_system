import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/profit_entity.dart';

class TopProfitableProductsList extends StatelessWidget {
  final List<TopProductEntity> products;
  const TopProfitableProductsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("أكثر المنتجات تحقيقاً للربح", style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp, fontWeight: FontWeight.w700, color: const Color(0xff111827))),
          SizedBox(height: 12.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(image: NetworkImage(product.imageUrl), fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(product.name, style: TextStyle(fontFamily: 'Cairo', fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xff111827))),
                          Text("${product.unitsSold} وحدة مباعة", style: TextStyle(fontFamily: 'Cairo', fontSize: 11.sp, color: const Color(0xff6B7280))),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("صافي الربح", style: TextStyle(fontFamily: 'Cairo', fontSize: 10.sp, color: const Color(0xff9CA3AF))),
                        Text("+${product.netProfit.toStringAsFixed(0)}", style: TextStyle(fontFamily: 'Cairo', fontSize: 13.sp, fontWeight: FontWeight.w700, color: const Color(0xff10B981))),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}