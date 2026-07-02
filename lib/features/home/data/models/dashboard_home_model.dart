import '../../domain/entities/dashboard_home_entity.dart';
import 'greeting_model.dart';
import 'kpi_model.dart';
import 'profit_model.dart';
import 'dashboard_chart_point_model.dart'; // ✅ الاسم الجديد النظيف
import 'dashboard_low_stock_model.dart';
import 'notification_model.dart';

class DashboardHomeModel extends DashboardHomeEntity {
  const DashboardHomeModel({
    required super.greeting,
    required super.kpi,
    required super.profit,
    required super.salesChart,
    required super.lowStock,
    required super.notifications,
  });

  factory DashboardHomeModel.fromJson(Map<String, dynamic> json) {
    return DashboardHomeModel(
      greeting: GreetingModel.fromJson(json['greeting'] ?? {}),
      kpi: KpiModel.fromJson(json['kpi'] ?? {}),
      profit: ProfitModel.fromJson(json['profit'] ?? {}),
      salesChart: (json['salesChart'] as List? ?? [])
          .map((e) => DashboardChartPointModel.fromJson(e)) // ✅ تم التعديل هنا
          .toList(),
      lowStock: (json['lowStock'] as List? ?? [])
          .map((e) => DashboardLowStockModel.fromJson(e))
          .toList(),
      notifications: (json['notifications'] as List? ?? [])
          .map((e) => NotificationModel.fromJson(e))
          .toList(),
    );
  }
}