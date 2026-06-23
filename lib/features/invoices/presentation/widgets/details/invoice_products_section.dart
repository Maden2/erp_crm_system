import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../domain/entities/invoice_entity.dart';

class InvoiceProductsSection extends StatelessWidget {
  final InvoiceEntity invoice;

  const InvoiceProductsSection({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Text(
              "المنتجات",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: const Color(0xFF111827),
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: invoice.products.length,
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(
                color: const Color(0xFFE0E0E0),
                height: 1.h,
                thickness: 0.3.w,
              ),
            ),
            itemBuilder: (context, index) {
              final product = invoice.products[index];
              return Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName,
                          style: TextStyles.font12BlackMedium,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "الكمية: ${product.quantity}",
                          style: TextStyle(
                            color: const Color(0xFF6B7280),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        Text(
                          product.price,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10.sp,
                            color: AppColors.blackColor,
                          ),
                        ),
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
