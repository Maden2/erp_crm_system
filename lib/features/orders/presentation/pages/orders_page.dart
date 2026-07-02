import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import 'package:pivot/core/widgets/custom_app_bar.dart';
import '../../../../core/di/service_locator.dart';
import '../manager/live_orders_cubit.dart';
import '../manager/live_orders_state.dart';
import '../widgets/empty_orders_widget.dart';
import '../widgets/order_card.dart';
import '../widgets/orders_tab_bar.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  // 🟢 تم تحديث الـ Tabs لتطابق مسميات السيرفر العربي
  final List<String> _tabs = ["ملغى", "تم التسليم", "قيد الشحن", "قيد الانتظار", "الكل"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // 🟢 الربط بالـ LiveOrdersCubit وجلب داتا السيرفر لأول مرة
      create: (context) => getIt<LiveOrdersCubit>()..getLiveOrders(statusTab: "الكل"),
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        appBar: CustomAppBar(
          title: Text("الطلبات", style: TextStyles.font20WhiteMedium),
          leading: IconButton(
            padding: EdgeInsets.only(right: 24.w),
            icon: Icon(Icons.tune, color: AppColors.homeBg, size: 24.sp),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.only(left: 24.w),
              icon: Icon(Icons.search, color: AppColors.homeBg, size: 24.sp),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Builder(
              builder: (blocContext) {
                return OrdersTabBar(
                  tabs: _tabs,
                  onTap: (index) {
                    // 🟢 تنده على الـ Cubit الحقيقي بالـ Tab المختار
                    blocContext.read<LiveOrdersCubit>().getLiveOrders(statusTab: _tabs[index]);
                  },
                );
              },
            ),
            Expanded(
              child: BlocBuilder<LiveOrdersCubit, LiveOrdersState>(
                builder: (context, state) {
                  if (state is LiveOrdersLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    );
                  } else if (state is LiveOrdersSuccess) {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        return OrderCard(order: state.orders[index]);
                      },
                    );
                  } else if (state is LiveOrdersEmpty) {
                    return const EmptyOrdersWidget();
                  } else if (state is LiveOrdersFailure) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}