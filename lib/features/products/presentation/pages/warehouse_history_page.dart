import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/warehouse_history_cubit.dart';
import '../manager/warehouse_history_state.dart';

class WarehouseHistoryPage extends StatelessWidget {
  const WarehouseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      appBar: CustomAppBar(
        title: Text(
          "تاريخ إضافة المخزون",
          style: TextStyles.font18WhiteBold.copyWith(fontFamily: 'Cairo'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              context.read<WarehouseHistoryCubit>().getHistory();
            },
          ),
        ],
      ),
      body: BlocBuilder<WarehouseHistoryCubit, WarehouseHistoryState>(
        builder: (context, state) {
          if (state is WarehouseHistoryLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is WarehouseHistorySuccess) {
            final historyList = state.history;

            if (historyList.isEmpty) {
              return const Center(
                child: Text(
                  "لا يوجد سجلات حالياً",
                  style: TextStyle(fontFamily: 'Cairo'),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(16.r),
              itemCount: historyList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final item = historyList[index];
                return _buildHistoryCard(
                  name: item.userName,
                  date: item.date,
                  productsCount: "${item.productsCount} المنتجات",
                  category: item.category,
                );
              },
            );
          }

          if (state is WarehouseHistoryFailure) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontFamily: 'Cairo', color: Colors.red),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildHistoryCard({
    required String name,
    required String date,
    required String productsCount,
    required String category,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 11.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: const Color(0xFF1E293B),
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10.sp,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(height: 12.h),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 14.sp,
                    color: Colors.grey.shade400,
                  ),

                  SizedBox(width: 6.w),
                  Text(productsCount, style: _subTextStyle()),
                ],
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 14.sp,
                    color: Colors.grey.shade400,
                  ),

                  SizedBox(width: 6.w),
                  Text(category, style: _subTextStyle()),
                ],
              ),
            ],
          ),

          const Spacer(),
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey.shade400,
            size: 24.sp,
          ),
        ],
      ),
    );
  }

  TextStyle _subTextStyle() {
    return TextStyle(
      fontFamily: 'Cairo',
      fontSize: 12.sp,
      color: Colors.grey.shade600,
    );
  }
}
