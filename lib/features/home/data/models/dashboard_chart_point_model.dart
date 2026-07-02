import '../../domain/entities/dashboard_chart_point_entity.dart';

class DashboardChartPointModel extends DashboardChartPointEntity {
  const DashboardChartPointModel({
    required super.day,
    required super.ordersCount,
    required super.revenue,
    required super.isFallback,
  });

  factory DashboardChartPointModel.fromJson(Map<String, dynamic> json) {
    return DashboardChartPointModel(
      day: json['day'] ?? '',
      ordersCount: json['ordersCount'] ?? 0,
      revenue: (json['revenue'] ?? 0).toDouble(),
      isFallback: json['isFallback'] ?? false,
    );
  }
}