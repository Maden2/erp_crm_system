import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../domain/entities/website_product_entities.dart'; //[cite: 10]

class ProductCard extends StatelessWidget {
  final WebsiteProductItemEntity product; // ربطه بالـ الـ Entity الحقيقية للويب[cite: 10]

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h), //[cite: 10]
      padding: EdgeInsets.all(12.r), //[cite: 10]
      decoration: BoxDecoration(
        color: AppColors.authBgColor, //[cite: 10]
        borderRadius: BorderRadius.circular(8.r), //[cite: 10]
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03), //[cite: 10]
            blurRadius: 10, //[cite: 10]
            offset: const Offset(0, 4), //[cite: 10]
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.ltr, //[cite: 10]
        crossAxisAlignment: CrossAxisAlignment.start, //[cite: 10]
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.h), //[cite: 10]
            child: Icon(Icons.more_vert, color: Colors.grey[400], size: 16.sp), //[cite: 10]
          ),
          const Spacer(), //[cite: 10]
          Expanded(
            flex: 6, //[cite: 10]
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, //[cite: 10]
              children: [
                Text(product.name, style: TextStyles.font12BlackMedium), //[cite: 10]
                SizedBox(height: 6.h), //[cite: 10]
                Text(
                  "${product.salePrice} ج.م", // ربط السعر الحقيقي[cite: 10]
                  style: TextStyles.font10LightGreyRegular, //[cite: 10]
                ),
                SizedBox(height: 8.h), //[cite: 10]
                Wrap(
                  alignment: WrapAlignment.end, //[cite: 10]
                  spacing: 6.w, //[cite: 10]
                  runSpacing: 4.h, //[cite: 10]
                  children: [
                    _buildStatusTag(product.quantity, product.stockStatus == "low"), //[cite: 10]
                    _buildStockTag(product.quantity), //[cite: 10]
                  ],
                ),
                SizedBox(height: 8.h), //[cite: 10]
                _buildSkuTag(product.sku), //[cite: 10]
              ],
            ),
          ),
          SizedBox(width: 12.w), //[cite: 10]
          Container(
            width: 48.w, //[cite: 10]
            height: 48.h, //[cite: 10]
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r), //[cite: 10]
              color: const Color(0xFFF1F5F9), //[cite: 10]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r), //[cite: 10]
              child: product.image.isNotEmpty
                  ? Image.network(
                product.image, //[cite: 10]
                fit: BoxFit.cover, //[cite: 10]
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.broken_image_outlined,
                  color: Colors.grey[300], //[cite: 10]
                ),
              )
                  : Icon(
                Icons.image_outlined,
                color: Colors.grey[300], //[cite: 10]
                size: 30.sp, //[cite: 10]
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTag(int quantity, bool isLowStock) {
    final bool isOutOfStock = quantity == 0; //[cite: 10]
    final bool showWarning = isOutOfStock || isLowStock; //[cite: 10]

    String text = "المخزون مستقر"; //[cite: 10]
    Color bgColor = const Color(0x144379EE); //[cite: 10]
    Color textColor = const Color(0xFF4379EE); //[cite: 10]

    if (isOutOfStock) {
      text = "نفاد المخزون"; //[cite: 10]
      bgColor = const Color(0x14EF4C53); //[cite: 10]
      textColor = AppColors.redColor; //[cite: 10]
    } else if (isLowStock) {
      text = "منخفض المخزون"; //[cite: 10]
      bgColor = const Color(0x14EF4C53); //[cite: 10]
      textColor = AppColors.redColor; //[cite: 10]
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h), //[cite: 10]
      decoration: BoxDecoration(
        color: bgColor, //[cite: 10]
        borderRadius: BorderRadius.circular(8.r), //[cite: 10]
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, //[cite: 10]
        textDirection: TextDirection.rtl, //[cite: 10]
        children: [
          if (showWarning) ...[
            Icon(Icons.warning_amber_rounded, color: textColor, size: 10.sp), //[cite: 10]
            SizedBox(width: 4.w), //[cite: 10]
          ],
          Text(
            text, //[cite: 10]
            style: TextStyle(
              fontSize: 9.sp, //[cite: 10]
              color: textColor, //[cite: 10]
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400, //[cite: 10]
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockTag(int quantity) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h), //[cite: 10]
      decoration: BoxDecoration(
        color: const Color(0x14979797), //[cite: 10]
        borderRadius: BorderRadius.circular(8.r), //[cite: 10]
      ),
      child: Text(
        "المخزون: $quantity", //[cite: 10]
        style: TextStyle(
          fontSize: 9.sp, //[cite: 10]
          color: Colors.grey[600], //[cite: 10]
          fontFamily: 'Cairo',
        ),
      ),
    );
  }

  Widget _buildSkuTag(String sku) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h), //[cite: 10]
      decoration: BoxDecoration(
        color: const Color(0x14979797), //[cite: 10]
        borderRadius: BorderRadius.circular(8.r), //[cite: 10]
      ),
      child: Text(
        "SKU: $sku", //[cite: 10]
        style: const TextStyle(
          fontSize: 9,
          color: Color(0xFF848688), //[cite: 10]
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}