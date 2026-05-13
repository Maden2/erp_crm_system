import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Icon(Icons.more_vert, color: Colors.grey[400], size: 16.sp),
          ),

          const Spacer(),

          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    product.name,
                    style: TextStyles.font12BlackMedium
                ),
                SizedBox(height: 6.h),
                Text(
                    "${product.price} ج.م",
                    style: TextStyles.font10LightGreyRegular
                ),
                SizedBox(height: 8.h),


                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 6.w,
                  runSpacing: 4.h,
                  children: [
                    _buildStatusTag(product.quantity,product.isLowStock),

                    _buildStockTag(product.quantity),
                  ],
                ),
                SizedBox(height: 8.h),


                _buildSkuTag(product.sku),
              ],
            ),
          ),

          SizedBox(width: 12.w),


          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: const Color(0xFFF1F5F9),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: product.image.isNotEmpty
                  ? Image.network(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.broken_image_outlined,
                  color: Colors.grey[300],
                ),
              )
                  : Icon(
                Icons.image_outlined,
                color: Colors.grey[300],
                size: 30.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTag(int quantity, bool isLowStock) {

    final bool isOutOfStock = quantity == 0;
    final bool showWarning = isOutOfStock || isLowStock;


    String text = "المخزون مستقر";
    Color bgColor = const Color(0x144379EE);
    Color textColor = Color(0xFF4379EE);

    if (isOutOfStock) {
      text = "نفاد المخزون";
      bgColor = const Color(0x14EF4C53);
      textColor = AppColors.redColor;
    } else if (isLowStock) {
      text = "منخفض المخزون";
      bgColor = const Color(0x14EF4C53);
      textColor = AppColors.redColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.rtl,
        children: [

          if (showWarning) ...[
            Icon(
              Icons.warning_amber_rounded,
              color: textColor,
              size: 10.sp,
            ),
            SizedBox(width: 4.w),
          ],

          Text(
            text,
            style: TextStyle(
              fontSize: 9.sp,
              color: textColor,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }  Widget _buildStockTag(int quantity) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0x14979797),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        "المخزون: $quantity",
        style: TextStyle(
          fontSize: 9.sp,
          color: Colors.grey[600],
          fontFamily: 'Cairo',
        ),
      ),
    );
  }


  Widget _buildSkuTag(String sku) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0x14979797),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        "SKU: $sku",
        style: TextStyle(
          fontSize: 9.sp,
          color: Color(0xFF848688),
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}