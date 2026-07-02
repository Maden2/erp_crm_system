import '../../domain/entities/kpi_entity.dart';

class KpiModel extends KpiEntity {
  const KpiModel({
    required super.todaySales,
    required super.todayOrdersCount,
    required super.monthlySales,
    required super.monthlyOrdersCount,
    required super.newOrdersLastHour,
    required super.todayVsYesterdayPct,
    required super.monthVsLastMonthPct,
  });

  factory KpiModel.fromJson(Map<String, dynamic> json) {
    return KpiModel(
      todaySales: (json['todaySales'] ?? 0).toDouble(),
      todayOrdersCount: json['todayOrdersCount'] ?? 0,
      monthlySales: (json['monthlySales'] ?? 0).toDouble(),
      monthlyOrdersCount: json['monthlyOrdersCount'] ?? 0,
      newOrdersLastHour: json['newOrdersLastHour'] ?? 0,
      todayVsYesterdayPct: (json['todayVsYesterdayPct'] ?? 0).toDouble(),
      monthVsLastMonthPct: (json['monthVsLastMonthPct'] ?? 0).toDouble(),
    );
  }
}