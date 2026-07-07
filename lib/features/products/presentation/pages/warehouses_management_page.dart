import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

import '../../../../app/app_routes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../domain/entities/warehouse_entity.dart';

class WarehousesManagementPage extends StatelessWidget {
  const WarehousesManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<WarehouseEntity> warehouses = [
      WarehouseEntity(
        id: "1",
        name: "الكترونيات",
        icon: Icons.inventory_2_outlined,
      ),
      WarehouseEntity(id: "2", name: "ملابس", icon: Icons.inventory_2_outlined),
      WarehouseEntity(id: "3", name: "العاب", icon: Icons.inventory_2_outlined),
    ];

    return Scaffold(
      backgroundColor: AppColors.homeBg,
      appBar: CustomAppBar(
        title: Text(
          "إدارة المخزون",
          style: TextStyles.font18WhiteBold.copyWith(fontFamily: 'Cairo'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("جميع المخزون", style: TextStyles.font20PrimaryMedium),
                _buildAddSmallButton(context),
              ],
            ),

            SizedBox(height: 16.h),

            _buildHistoryBanner(context),

            SizedBox(height: 20.h),

            Expanded(
              child: ListView.builder(
                itemCount: warehouses.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    _buildWarehouseCard(warehouses[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddSmallButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.addWarehouse);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(17.r),
        ),
        child: Row(
          children: [
            Icon(Icons.add, color: AppColors.homeBg, size: 16.sp),
            SizedBox(width: 4.w),
            Text("إضافة مخزون", style: TextStyles.font14lightWhiteRegular),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryBanner(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.warehouseHistory);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.goldenOrange,
          borderRadius: BorderRadius.circular(17.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, color: AppColors.homeBg, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              "تاريخ إضافة المخزون",
              style: TextStyles.font14lightWhiteRegular,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarehouseCard(WarehouseEntity warehouse) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(13.r),
            decoration: BoxDecoration(
              color: const Color(0xFFD6F4EE),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Icon(
              warehouse.icon,
              color: const Color(0xFF00B69B),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Text(warehouse.name, style: TextStyles.font14BlackMedium),
          const Spacer(),
          Icon(Icons.more_vert, color: AppColors.lightGrayText, size: 20.sp),
        ],
      ),
    );
  }
}