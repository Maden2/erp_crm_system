class KpiEntity {
  final num todaySales;
  final num todayOrdersCount;
  final num monthlySales;
  final num monthlyOrdersCount;
  final num newOrdersLastHour;
  final num todayVsYesterdayPct;
  final num monthVsLastMonthPct;

  const KpiEntity({
    required this.todaySales,
    required this.todayOrdersCount,
    required this.monthlySales,
    required this.monthlyOrdersCount,
    required this.newOrdersLastHour,
    required this.todayVsYesterdayPct,
    required this.monthVsLastMonthPct,
  });
}