import 'package:flutter_bloc/flutter_bloc.dart';
import 'profits_state.dart';
import '../../domain/entities/profit_entity.dart';

class ProfitsCubit extends Cubit<ProfitsState> {
  ProfitsCubit() : super(ProfitsInitial());

  void fetchProfitsData({String timeFrame = "يومي"}) {
    emit(ProfitsLoading());

    final mockData = ProfitEntity(
      summaries: [
        const ProfitSummaryEntity(
          title: "إجمالي الإيرادات",
          value: 125000,
          iconPath: "assets/icons/dollar.svg",
          isPositive: true,
        ),
        const ProfitSummaryEntity(
          title: "إجمالي التكاليف",
          value: 45000,
          iconPath: "assets/icons/costs.svg",
          isPositive: false,
        ),
      ],
      chartData: [
        const ChartDataPoint(dayName: "السبت", revenue: 40, costs: 20, netProfit: 80),
        const ChartDataPoint(dayName: "الأحد", revenue: 110, costs: 50, netProfit: 190),
        const ChartDataPoint(dayName: "الاثنين", revenue: 30, costs: 60, netProfit: 120),
        const ChartDataPoint(dayName: "الثلاثاء", revenue: 140, costs: 70, netProfit: 130),
        const ChartDataPoint(dayName: "الأربعاء", revenue: 160, costs: 130, netProfit: 190),
        const ChartDataPoint(dayName: "الخميس", revenue: 70, costs: 30, netProfit: 70),
        const ChartDataPoint(dayName: "الجمعة", revenue: 50, costs: 20, netProfit: 100),
      ],
      topProducts: [
        const TopProductEntity(
          name: "هاتف iPhone 17 Pro",
          unitsSold: 120,
          netProfit: 15000,
          imageUrl: "https://images.unsplash.com/photo-1695048133142-1a20484d2569",
        ),
        const TopProductEntity(
          name: "Apple iPhone 16 Pro",
          unitsSold: 85,
          netProfit: 8500,
          imageUrl: "https://images.unsplash.com/photo-1616348436168-de43ad0db179",
        ),
        const TopProductEntity(
          name: "iPhone 15 Plus",
          unitsSold: 200,
          netProfit: 6000,
          imageUrl: "https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5",
        ),
      ],
      operationalCosts: [
        const OperationalCostEntity(
          title: "الشحن والتوصيل",
          amount: 12500,
          iconPath: "assets/icons/shipping.svg",
          colorHex: 0xffEEF2F6,
        ),
        const OperationalCostEntity(
          title: "التسويق والإعلانات",
          amount: 8500,
          iconPath: "assets/icons/marketing.svg",
          colorHex: 0xffEEF2F6,
        ),
        const OperationalCostEntity(
          title: "مصروفات تشغيلية",
          amount: 4500,
          iconPath: "assets/icons/operations.svg",
          colorHex: 0xffEEF2F6,
        ),
      ],
    );

    emit(ProfitsSuccess(profitData: mockData, selectedTimeFrame: timeFrame));
  }

  void changeTimeFrame(String newTimeFrame) {
    fetchProfitsData(timeFrame: newTimeFrame);
  }
}