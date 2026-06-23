import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import 'package:pivot/core/widgets/custom_app_bar.dart';
import '../../../../core/di/service_locator.dart';
import '../manager/orders_cubit.dart';
import '../manager/orders_state.dart';
import '../widgets/empty_orders_widget.dart';
import '../widgets/order_card.dart';
import '../widgets/orders_tab_bar.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ["ملغى", "تم التسليم", "قيد الشحن", "جديد"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrdersCubit>()..getOrders(status: "جديد"),
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        appBar: CustomAppBar(
          title: Text("الطلبات", style: TextStyles.font20WhiteMedium),
          leading: IconButton(
            padding: EdgeInsets.only(right: 24.w),
            icon: Icon(Icons.tune, color: AppColors.homeBg, size: 24.sp),
            onPressed: () {
              // TODO: ربط الفلترة المتقدمة
            },
          ),

          actions: [
            IconButton(
              padding: EdgeInsets.only(left: 24.w),

              icon: Icon(Icons.search, color: AppColors.homeBg, size: 24.sp),
              onPressed: () {
                // TODO: ربط البحث
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Builder(
              builder: (context) {
                return OrdersTabBar(
                  tabs: _tabs,
                  onTap: (index) {
                    context.read<OrdersCubit>().changeStatus(_tabs[index]);
                  },
                );
              },
            ),

            Expanded(
              child: BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  if (state is OrdersLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  } else if (state is OrdersSuccess) {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        return OrderCard(order: state.orders[index]);
                      },
                    );
                  } else if (state is OrdersEmpty) {
                    return const EmptyOrdersWidget();
                  } else if (state is OrdersFailure) {
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
