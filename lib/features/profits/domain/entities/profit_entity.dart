class ProfitSummaryEntity {
  final String title;
  final double value;
  final String iconPath;
  final bool isPositive;

  const ProfitSummaryEntity({
    required this.title,
    required this.value,
    required this.iconPath,
    required this.isPositive,
  });
}

class ChartDataPoint {
  final String dayName;
  final double revenue;
  final double costs;
  final double netProfit;

  const ChartDataPoint({
    required this.dayName,
    required this.revenue,
    required this.costs,
    required this.netProfit,
  });
}

class TopProductEntity {
  final String name;
  final int unitsSold;
  final double netProfit;
  final String imageUrl;

  const TopProductEntity({
    required this.name,
    required this.unitsSold,
    required this.netProfit,
    required this.imageUrl,
  });
}

class OperationalCostEntity {
  final String title;
  final double amount;
  final String iconPath;
  final int colorHex;

  const OperationalCostEntity({
    required this.title,
    required this.amount,
    required this.iconPath,
    required this.colorHex,
  });
}

class ProfitEntity {
  final List<ProfitSummaryEntity> summaries;
  final List<ChartDataPoint> chartData;
  final List<TopProductEntity> topProducts;
  final List<OperationalCostEntity> operationalCosts;

  const ProfitEntity({
    required this.summaries,
    required this.chartData,
    required this.topProducts,
    required this.operationalCosts,
  });
}