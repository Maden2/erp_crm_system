class DashboardChartPointEntity {
  final String day;
  final num ordersCount;
  final num revenue;
  final bool isFallback;

  const DashboardChartPointEntity({
    required this.day,
    required this.ordersCount,
    required this.revenue,
    required this.isFallback,
  });
}