import 'dashboard_low_stock_entity.dart';
import 'greeting_entity.dart';
import 'kpi_entity.dart';
import 'profit_entity.dart';
import 'dashboard_chart_point_entity.dart';
import 'notification_entity.dart';

class DashboardHomeEntity {
  final GreetingEntity greeting;
  final KpiEntity kpi;
  final ProfitEntity profit;
  final List<DashboardChartPointEntity> salesChart;
  final List<DashboardLowStockEntity> lowStock;
  final List<NotificationEntity> notifications;

  const DashboardHomeEntity({
    required this.greeting,
    required this.kpi,
    required this.profit,
    required this.salesChart,
    required this.lowStock,
    required this.notifications,
  });
}