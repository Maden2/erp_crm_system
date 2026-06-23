import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

import '../../../../app/app_routes.dart';
import '../manager/product_details_cubit.dart';
import '../manager/product_details_state.dart';

import '../widgets/details/color_selector.dart';
import '../widgets/details/price_chart.dart';
import '../widgets/details/product_description_section.dart';
import '../widgets/details/product_image_slider.dart';
import '../widgets/details/product_info_table.dart';
import '../widgets/details/product_stock_badge.dart';
import '../widgets/details/product_warning_banner.dart';
import '../widgets/details/size_selector.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBgColor,
      body: SafeArea(
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.mainBlue),
              );
            } else if (state is ProductDetailsSuccess) {
              final p = state.product;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // ================= PRODUCT IMAGES & ACTIONS =================
                    Stack(
                      children: [
                        ProductImageSlider(images: p.images),

                        Positioned(
                          top: 12.h,
                          left: 12.w,
                          child: PopupMenuButton<String>(
                            icon: Icon(
                              Icons.more_vert,
                              color: const Color(0xFF1E293B),
                              size: 28.sp,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            onSelected: (value) {
                              if (value == 'copy') {
                                Navigator.pushNamed(
                                  context,
                                  Routes.copyProductPage,
                                  arguments: p,
                                );
                              }
                            },
                            itemBuilder: (context) => [
                              _buildPopupItem(
                                "تعديل",
                                Icons.edit_outlined,
                                "edit",
                                const Color(0xFF1E293B),
                              ),
                              _buildPopupItem(
                                "نسخ",
                                Icons.copy_all_outlined,
                                "copy",
                                const Color(0xFF1E293B),
                              ),
                              _buildPopupItem(
                                "حذف",
                                Icons.delete_outline_rounded,
                                "delete",
                                const Color(0xFFEF4444),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // ================= CONTENT =================
                    Transform.translate(
                      offset: Offset(0, -45.h),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.authBgColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(17.r),
                            topRight: Radius.circular(17.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 17.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 20.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        p.name,
                                        style:
                                            TextStyles.font16graphiteGreyMedium,
                                      ),
                                      ProductStockBadge(stock: p.stock),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${p.price} ج.م",
                                          style: TextStyles
                                              .font22graphiteGreyMedium,
                                        ),
                                        SizedBox(height: 14.h),
                                        Text(
                                          "${p.stock} قطعة",
                                          style: TextStyles
                                              .font16graphiteGreyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            _buildDivider(),
                            ProductWarningBanner(stock: p.stock),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 17.w),
                              child: Column(
                                children: [
                                  _buildSectionTitle("الألوان المتوفرة"),
                                  ColorSelector(colors: p.colors),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 17.w),
                              child: Column(
                                children: [
                                  _buildSectionTitle("المقاسات"),
                                  SizeSelector(sizes: p.sizes),
                                  SizedBox(height: 16.h),
                                ],
                              ),
                            ),
                            _buildDivider(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 17.w),
                              child: Column(
                                children: [
                                  _buildSectionTitle("تفاصيل المنتج"),
                                  ProductInfoTable(product: p),
                                  SizedBox(height: 16.h),
                                ],
                              ),
                            ),
                            _buildDivider(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 17.w),
                              child: Column(
                                children: [
                                  _buildSectionTitle("معدل السعر"),
                                  PriceChart(
                                    key: ValueKey(p.id),
                                    data: p.priceHistory,
                                  ),
                                  SizedBox(height: 16.h),
                                ],
                              ),
                            ),
                            _buildDivider(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 17.w),
                              child: Column(
                                children: [
                                  _buildSectionTitle("وصف المنتج"),
                                  ProductDescriptionSection(
                                    description: p.description,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ProductDetailsFailure) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(
    String title,
    IconData icon,
    String value,
    Color color,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyles.font12blackColorRegular.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          textDirection: TextDirection.rtl,
          style: TextStyles.font18graphiteGreyMedium,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 1.h,
      color: AppColors.lightDivider,
    );
  }
}
