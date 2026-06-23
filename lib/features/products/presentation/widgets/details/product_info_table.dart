import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../domain/entities/product_details_entity.dart';

class ProductInfoTable extends StatelessWidget {
  final ProductDetailsEntity product;

  const ProductInfoTable({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 12.h),

        _buildRow("الفئة", product.category ?? "هواتف"),

        SizedBox(height: 8.h),

        _buildRow("SKU", product.sku),

        SizedBox(height: 8.h),

        _buildRow("الحالة", product.stock > 0 ? "متاح" : "غير متاح"),

        SizedBox(height: 8.h),

        _buildRow("الحد الأدنى", "${product.minOrder ?? 4}"),
      ],
    );
  }

  Widget _buildRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),

      decoration: BoxDecoration(
        color: AppColors.lightBlueGrey,
        borderRadius: BorderRadius.circular(8.r),
      ),

      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            label,
            textDirection: TextDirection.rtl,
            style: TextStyles.font14graphiteGreyRegular,
          ),

          Text(value, style: TextStyles.font14graphiteGreyRegular),
        ],
      ),
    );
  }
}
