import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/customer_cubit.dart';
import '../manager/customer_state.dart';
import '../widgets/customer_kpi_header.dart';
import '../widgets/customer_card.dart';
import '../widgets/empty_customers_widget.dart';
import '../widgets/customer_filter_bottom_sheet.dart';
import 'customer_details_page.dart'; // 🟢 استدعاء شاشة التفاصيل الجديدة

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  void _openFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CustomerFilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomerCubit()..fetchCustomers(isEmptyCase: false),
      child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: AppColors.homeBg,
              appBar: CustomAppBar(
                // 🟢 سهم الرجوع مكان أيقونة الفلتر
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "العملاء",
                  style: TextStyles.font20WhiteMedium,
                ),
                actions: [
                  IconButton(
                    icon:  Icon(Icons.tune, color: AppColors.homeBg),
                    onPressed: () => _openFilter(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: AppColors.homeBg),
                    onPressed: () {},
                  ),
                  SizedBox(width: 8.w),
                ],
              ),
              body: BlocBuilder<CustomerCubit, CustomerState>(
                builder: (context, state) {
                  if (state is CustomerLoading) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                  }

                  if (state is CustomerSuccess) {
                    final list = state.customerList;

                    if (list.customers.isEmpty) {
                      return const EmptyCustomersWidget();
                    }

                    return Column(
                      children: [
                        CustomerKpiHeader(
                          totalCount: list.totalCount,
                          activeCount: list.activeCount,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "قائمة العملاء",
                              style: TextStyles.font16graphiteGreyMedium,
                            ),
                          ),
                        ),

                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            physics: const BouncingScrollPhysics(),
                            itemCount: list.customers.length,
                            itemBuilder: (context, index) {
                              final customer = list.customers[index];
                              return CustomerCard(
                                customer: customer,
                                // 🟢 تعديل ميثود الـ onTap للانتقال السلس لشاشة تفاصيل العميل مع الـ ID
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CustomerDetailsPage(customerId: customer.id),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            );
          }
      ),
    );
  }
}