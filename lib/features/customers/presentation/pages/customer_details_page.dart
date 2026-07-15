import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/customer_cubit.dart';
import '../manager/customer_state.dart';
import '../widgets/details/customer_details_kpi.dart';
import '../widgets/details/customer_info_section.dart';
import '../widgets/details/customer_order_item.dart';

class CustomerDetailsPage extends StatelessWidget {
  final String customerId;

  const CustomerDetailsPage({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomerCubit()..fetchCustomerDetails(customerId),
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        appBar: CustomAppBar(
          // 1️⃣ زر الرجوع لوحده في الـ leading (يسار الشاشة)
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),

          // 2️⃣ الـ Title في المنتصف: الاسم والـ Badge الملون جمب بعض ومأمنين تماماً ضد الـ Overflow
          title: BlocBuilder<CustomerCubit, CustomerState>(
            builder: (context, state) {
              if (state is CustomerSuccess && state.selectedCustomerDetail != null) {
                final d = state.selectedCustomerDetail!;
                final bool isActive = d.id == "4" || d.id == "1";

                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // الـ Badge الملون (نشط / غير نشط)
                      Text(
                        d.name,
                        style: TextStyles.font16WhiteBold,
                      ),
                  
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: isActive ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 5.w,
                              height: 5.w,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              isActive ? "نشط" : "غير نشط",
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  
                      // اسم العميل
                    ],
                  ),
                );
              }
              return Text("تفاصيل العميل", style: TextStyles.font18WhiteBold.copyWith(fontFamily: 'Cairo'));
            },
          ),

          // 3️⃣ الـ Actions (يمين الشاشة): أيقونات البريد والاتصال مسطرة ومطابقة للتصميم بالملي
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppAssets.mailIcon,
                width: 24.w,
                height: 24.h,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppAssets.phoneIcon,
                width: 24.w,
                height: 24.h,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 4.w),
          ],        ),
        body: BlocBuilder<CustomerCubit, CustomerState>(
          builder: (context, state) {
            if (state is CustomerLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            if (state is CustomerSuccess && state.selectedCustomerDetail != null) {
              final d = state.selectedCustomerDetail!;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    CustomerDetailsKpi(
                      totalOrders: d.totalOrders,
                      totalPurchases: d.totalPurchases,
                      averageOrderValue: d.averageOrderValue,
                    ),
                    CustomerInfoSection(
                      phone: d.phone,
                      email: d.email,
                      regDate: d.registrationDate,
                      deliveryNotes: d.deliveryNotes,
                      rating: 4.3,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "سجل الطلبات",
                          style: TextStyles.font14BlackMedium.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: d.orderHistory.length,
                      itemBuilder: (context, index) {
                        return CustomerOrderItem(order: d.orderHistory[index]);
                      },
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}