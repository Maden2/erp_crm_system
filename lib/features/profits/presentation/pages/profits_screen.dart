import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../manager/profits_cubit.dart';
import '../manager/profits_state.dart';
import '../widgets/profits_header_section.dart';
import '../widgets/profits_summary_slider.dart';
import '../widgets/profits_analysis_chart.dart';
import '../widgets/top_profitable_products_list.dart';
import '../widgets/operational_costs_grid.dart';

class ProfitsScreen extends StatelessWidget {
  const ProfitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfitsCubit()..fetchProfitsData(),
      child: Scaffold(
        backgroundColor: const Color(0xffF8FAFC),
        body: BlocBuilder<ProfitsCubit, ProfitsState>(
          builder: (context, state) {
            if (state is ProfitsLoading) {
              return const Center(child: CircularProgressIndicator(color: Color(0xff0D256F)));
            } else if (state is ProfitsSuccess) {
              final data = state.profitData;
              return SafeArea(
                top: false,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfitsHeaderSection(selectedTimeFrame: state.selectedTimeFrame),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            SizedBox(height: 16.h),
                            ProfitsSummarySlider(summaries: data.summaries),
                            SizedBox(height: 20.h),
                            ProfitsAnalysisChart(chartPoints: data.chartData),
                            SizedBox(height: 20.h),
                            TopProfitableProductsList(products: data.topProducts),
                            SizedBox(height: 20.h),
                            OperationalCostsGrid(costs: data.operationalCosts),
                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}