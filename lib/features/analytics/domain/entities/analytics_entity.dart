class ChartDataEntity {
  final String day;
  final double value;
  ChartDataEntity(this.day, this.value);
}

class TopProductEntity {
  final String name;
  final String image;
  final int salesCount;
  final double totalRevenue;

  TopProductEntity({
    required this.name,
    required this.image,
    required this.salesCount,
    required this.totalRevenue,
  });
}

class CategoryPerformanceEntity {
  final String label;
  final double percentage;
  CategoryPerformanceEntity(this.label, this.percentage);
}

class AnalyticsEntity {
  final double totalSalesToday;
  final double salesChangePercentage;
  final List<ChartDataEntity> salesChart;

  final double netProfit;
  final double netProfitChangePercentage;
  final List<ChartDataEntity> netProfitChart;

  final int totalOrders;
  final double ordersChangePercentage;
  final List<ChartDataEntity> ordersChart;

  final double cancellationRate;
  final double cancellationChangePercentage;
  final List<ChartDataEntity> cancellationChart;

  final List<TopProductEntity> topProducts;
  final List<CategoryPerformanceEntity> categoryPerformance;

  AnalyticsEntity({
    required this.totalSalesToday,
    required this.salesChangePercentage,
    required this.salesChart,
    required this.netProfit,
    required this.netProfitChangePercentage,
    required this.netProfitChart,
    required this.totalOrders,
    required this.ordersChangePercentage,
    required this.ordersChart,
    required this.cancellationRate,
    required this.cancellationChangePercentage,
    required this.cancellationChart,
    required this.topProducts,
    required this.categoryPerformance,
  });
}
