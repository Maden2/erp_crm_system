import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/client_cubit.dart';
import '../manager/client_state.dart';
import '../widgets/customer_kpi_header.dart';
import '../widgets/customer_card.dart';
import '../widgets/empty_customers_widget.dart';
import '../widgets/customer_filter_bottom_sheet.dart';
import 'customer_details_page.dart';

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
      create: (_) => getIt<ClientCubit>()..fetchClients(),
      child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: AppColors.homeBg,
              appBar: CustomAppBar(
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
                    icon: Icon(Icons.tune, color: AppColors.homeBg),
                    onPressed: () => _openFilter(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: AppColors.homeBg),
                    onPressed: () {},
                  ),
                  SizedBox(width: 8.w),
                ],
              ),
              body: BlocBuilder<ClientCubit, ClientState>(
                builder: (context, state) {
                  if (state is ClientLoading) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                  }

                  if (state is ClientSuccess) {
                    // 🟢 تأمين الـ Nullability صب خرسانة باستخدام الـ Null-coalescing
                    final customersList = state.clients ?? [];
                    final stats = state.stats;

                    if (customersList.isEmpty) {
                      return const EmptyCustomersWidget();
                    }

                    return Column(
                      children: [
                        // 🟢 نمرر الإحصائيات فقط لو مش null، ولو null بنديله قيم افتراضية آمنة
                        CustomerKpiHeader(
                          totalCount: stats?.totalCustomers ?? 0,
                          activeCount: stats?.activeCustomers ?? 0,
                          activePercentage: stats?.activePercentage ?? "0%",
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
                            itemCount: customersList.length,
                            itemBuilder: (context, index) {
                              final client = customersList[index];
                              return CustomerCard(
                                client: client,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CustomerDetailsPage(customerId: client.id),
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
            );
          }
      ),
    );
  }
}