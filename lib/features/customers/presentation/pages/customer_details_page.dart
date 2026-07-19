import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/client_cubit.dart'; // 🟢 تم التوجيه للكيوبيت الجديد المعزول
import '../manager/client_state.dart'; // 🟢 تم التوجيه للـ State الجديد المعزول
import '../widgets/details/customer_details_kpi.dart';
import '../widgets/details/customer_info_section.dart';
import '../widgets/details/customer_order_item.dart';

class CustomerDetailsPage extends StatelessWidget {
  final String customerId;

  const CustomerDetailsPage({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ClientCubit>()..fetchClientDetails(customerId), // 🟢 سحب الكيوبيت الجديد المربوط بالـ Use Cases
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        appBar: CustomAppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: BlocBuilder<ClientCubit, ClientState>( // 🟢 استخدام الـ ClientCubit والـ ClientState
            builder: (context, state) {
              if (state is ClientSuccess && state.selectedClient != null) {
                final d = state.selectedClient!;
                final bool isActive = d.isActive; // 🟢 قراءة الحالة النشطة لايف من السيرفر

                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                    ],
                  ),
                );
              }
              return Text("تفاصيل العميل", style: TextStyles.font18WhiteBold.copyWith(fontFamily: 'Cairo'));
            },
          ),
        /*  actions: [
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
          ],*/
        ),
        body: BlocBuilder<ClientCubit, ClientState>( // 🟢 استخدام الـ ClientCubit والـ ClientState
          builder: (context, state) {
            if (state is ClientDetailsLoading || state is ClientLoading) { // 🟢 الـ States الجديدة للتحميل
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            if (state is ClientSuccess && state.selectedClient != null) {
              final d = state.selectedClient!;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    CustomerDetailsKpi(
                      totalOrders: d.totalOrders,
                      totalPurchases: d.totalSpending, // 🟢 ربط مع الـ Entity الجديد
                      averageOrderValue: d.averageOrderValue,
                    ),
                    CustomerInfoSection(
                      phone: d.phone,
                      email: d.email,
                      regDate: d.registrationDate,
                      deliveryNotes: d.note ?? '', // 🟢 التعامل مع النوت لو null
                      rating: d.rating, // 🟢 جلب التقييم الحقيقي من السيرفر
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
                      itemCount: d.orders.length, // 🟢 ربط مع الـ Entity الجديد لطلبات السيرفر
                      itemBuilder: (context, index) {
                        return CustomerOrderItem(order: d.orders[index]); // 🟢 تمرير الطلب المعدل
                      },
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              );
            }

            if (state is ClientError) {
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
      ),
    );
  }
}