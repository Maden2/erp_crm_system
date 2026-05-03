import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/low_stock_entity.dart';

class LowStockSection extends StatelessWidget {
  final List<LowStockEntity> products;

  const LowStockSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 20.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (_, __) => SizedBox(height: 20.h),
            itemBuilder: (context, index) =>
                _buildProductItem(products[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("منتجات قاربت على النفاد",
                style: TextStyles.font12BlackMedium),
            Text("راجع المخزون لتجنب نفاد المعروض",
                style: TextStyles.font8BlackRegular),
          ],
        ),
        Container(
          padding:
          EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEBEB),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded,
                  color: AppColors.redColor, size: 14),
              SizedBox(width: 4.w),
              Text("تنبيه مخزون",
                  style: TextStyles.font12redRegular,)


            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductItem(LowStockEntity product) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.w,vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF0FC),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              imageUrl: product.imageUrl ?? "",

              width: 48.w,
              height: 48.w,
              fit: BoxFit.cover,


              placeholder: (context, url) => Container(
                width: 48.w,
                height: 48.w,
                color: Colors.grey.shade200,
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),


              errorWidget: (context, url, error) => Container(
                width: 48.w,
                height: 48.w,
                color: Colors.grey.shade200,
                child: Icon(
                  Icons.image_not_supported,
                  size: 20.sp,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.productName,
                    style: TextStyles.font12BlackMedium),
                SizedBox(height: 6.h),
                Text(
                  "المتبقي ${product.remainingQuantity} قطع",
                  style: TextStyles.font12redRegular
                ),
              ],
            ),
          ),

          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              product.categoryName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: TextStyles.font12CoolGreyRegular,
            ),
          ),


        ],
      ),
    );
  }
}