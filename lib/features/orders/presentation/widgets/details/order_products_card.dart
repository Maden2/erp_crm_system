import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

import '../../../domain/entities/live_order_entity.dart';
import '../../../domain/entities/live_order_item_entity.dart';

class OrderProductsCard extends StatelessWidget {
  final LiveOrderEntity order; // 🟢 تم التحديث للـ Entity الحقيقية

  const OrderProductsCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // حماية آمنة لو الـ items مكنتش مبعوتة في الـ ريكويست الحالي
    final List<LiveOrderItemEntity> itemsList = order.items ?? [];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("المنتجات", style: TextStyles.font12darkTextMedium),
          itemsList.isEmpty
              ? Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: const Center(child: Text("لا توجد منتجات مضافة لهذا الطلب", style: TextStyle(fontFamily: 'Cairo'))),
          )
              : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemsList.length,
            separatorBuilder: (_, __) => Divider(height: 0.3.h, color: Colors.grey[200]),
            itemBuilder: (context, index) {
              final item = itemsList[index];
              return _buildProductItem(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(LiveOrderItemEntity item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: item.primaryImage != null
                ? Image.network(
              item.primaryImage!,
              width: 48.w,
              height: 48.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildFallbackImage(),
            )
                : _buildFallbackImage(),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productNameSnapshot, // 🟢 المسمى الجديد للسيرفر
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 13.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("الكمية: ", style: TextStyle(fontFamily: 'Cairo', fontSize: 11.sp, color: Colors.grey)),
                    Text("${item.quantity}", style: TextStyle(fontFamily: 'Cairo', fontSize: 11.sp, color: Colors.grey)),
                    SizedBox(width: 15.w),
                    Text("السعر: ", style: TextStyle(fontFamily: 'Cairo', fontSize: 11.sp, color: Colors.grey)),
                    Text("${item.unitPrice.toStringAsFixed(0)} ج.م", style: TextStyle(fontFamily: 'Cairo', fontSize: 11.sp, color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 2.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${item.finalPrice.toStringAsFixed(0)} ج.م", // 🟢 السعر النهائي المحسوب بعد خصم الـ Item
                    style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 13.sp, color: const Color(0xFF111827)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackImage() {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8.r)),
      child: const Icon(Icons.image_outlined, color: Colors.grey),
    );
  }
}