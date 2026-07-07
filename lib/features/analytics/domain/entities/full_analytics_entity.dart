import 'package:equatable/equatable.dart';

class FullAnalyticsEntity extends Equatable {
  final AnalyticsOverviewEntity overview;
  final AnalyticsProfitEntity profit;
  final AnalyticsSalesChartEntity salesChart;
  final List<AnalyticsProductEntity> topProducts;
  final List<AnalyticsCategoryEntity> categories;
  final List<AnalyticsStatusBreakdownEntity> statusBreakdown;
  final List<AnalyticsPaymentBreakdownEntity> paymentBreakdown;

  const FullAnalyticsEntity({
    required this.overview,
    required this.profit,
    required this.salesChart,
    required this.topProducts,
    required this.categories,
    required this.statusBreakdown,
    required this.paymentBreakdown,
  });

  @override
  List<Object?> get props => [
    overview,
    profit,
    salesChart,
    topProducts,
    categories,
    statusBreakdown,
    paymentBreakdown,
  ];
}

// ==========================================================================
// 📊 1. قسم ملخص الأداء العام (Overview KPIs)
// ==========================================================================
class AnalyticsOverviewEntity extends Equatable {
  final String period;
  final AnalyticsMetricEntity revenue;
  final AnalyticsOrdersMetricEntity orders; // 🟢 مدموجة وصحيحة هنا الآن
  final AnalyticsMetricEntity averageOrderValue;
  final AnalyticsAllTimeEntity allTime;

  const AnalyticsOverviewEntity({
    required this.period,
    required this.revenue,
    required this.orders,
    required this.averageOrderValue,
    required this.allTime,
  });

  @override
  List<Object?> get props => [period, revenue, orders, averageOrderValue, allTime];
}

/// كائن فرعي للقيم الـ double (Revenue & AOV)
class AnalyticsMetricEntity extends Equatable {
  final double current;
  final double previous;
  final double changePercent;
  final String trend; // "up" أو "down"

  const AnalyticsMetricEntity({
    required this.current,
    required this.previous,
    required this.changePercent,
    required this.trend,
  });

  @override
  List<Object?> get props => [current, previous, changePercent, trend];
}

/// 🟢 الكائن الفرعي المدمج للقيم الـ int (عدد الطلبات) عشان الإيرور يختفي تماماً
class AnalyticsOrdersMetricEntity extends Equatable {
  final int current;
  final int previous;
  final double changePercent;
  final String trend; // "up" أو "down"

  const AnalyticsOrdersMetricEntity({
    required this.current,
    required this.previous,
    required this.changePercent,
    required this.trend,
  });

  @override
  List<Object?> get props => [current, previous, changePercent, trend];
}

class AnalyticsAllTimeEntity extends Equatable {
  final double revenue;
  final int orders;

  const AnalyticsAllTimeEntity({
    required this.revenue,
    required this.orders,
  });

  @override
  List<Object?> get props => [revenue, orders];
}

// ==========================================================================
// 💰 2. قسم الأرباح والـ Margins (Profit Metrics)
// ==========================================================================
class AnalyticsProfitEntity extends Equatable {
  final String period;
  final double revenue;
  final double cogs;
  final double grossProfit;
  final double profitMarginPct;

  const AnalyticsProfitEntity({
    required this.period,
    required this.revenue,
    required this.cogs,
    required this.grossProfit,
    required this.profitMarginPct,
  });

  @override
  List<Object?> get props => [period, revenue, cogs, grossProfit, profitMarginPct];
}

// ==========================================================================
// 📈 3. قسم مخطط المبيعات والطلبات (Sales & Orders Line Chart)
// ==========================================================================
class AnalyticsSalesChartEntity extends Equatable {
  final String period;
  final List<AnalyticsChartPointEntity> chart;
  final bool isFallback;

  const AnalyticsSalesChartEntity({
    required this.period,
    required this.chart,
    required this.isFallback,
  });

  @override
  List<Object?> get props => [period, chart, isFallback];
}

class AnalyticsChartPointEntity extends Equatable {
  final String date;
  final int ordersCount;
  final double revenue;
  final double aov;
  final bool isFallback;

  const AnalyticsChartPointEntity({
    required this.date,
    required this.ordersCount,
    required this.revenue,
    required this.aov,
    required this.isFallback,
  });

  @override
  List<Object?> get props => [date, ordersCount, revenue, aov, isFallback];
}

// ==========================================================================
// 📦 4. قسم المنتجات الأكثر مبيعاً (Top Products)
// ==========================================================================
class AnalyticsProductEntity extends Equatable {
  final int rank;
  final String productName;
  final String sku;
  final int unitsSold;
  final double revenue;
  final double avgPrice;
  final String image;

  const AnalyticsProductEntity({
    required this.rank,
    required this.productName,
    required this.sku,
    required this.unitsSold,
    required this.revenue,
    required this.avgPrice,
    required this.image,
  });

  @override
  List<Object?> get props => [rank, productName, sku, unitsSold, revenue, avgPrice, image];
}

// ==========================================================================
// 🏷️ 5. قسم مبيعات الفئات (Categories Performance)
// ==========================================================================
class AnalyticsCategoryEntity extends Equatable {
  final String category;
  final int unitsSold;
  final double revenue;
  final double sharePct;

  const AnalyticsCategoryEntity({
    required this.category,
    required this.unitsSold,
    required this.revenue,
    required this.sharePct,
  });

  @override
  List<Object?> get props => [category, unitsSold, revenue, sharePct];
}

// ==========================================================================
// 🍩 6. قسم توزيع الحالات للرسم الدائري (Status Donut Chart)
// ==========================================================================
class AnalyticsStatusBreakdownEntity extends Equatable {
  final int status;
  final String label;
  final String labelEn;
  final String color; // كود الـ Hex للرسم البياني مباشرة
  final int orderCount;
  final double revenue;

  const AnalyticsStatusBreakdownEntity({
    required this.status,
    required this.label,
    required this.labelEn,
    required this.color,
    required this.orderCount,
    required this.revenue,
  });

  @override
  List<Object?> get props => [status, label, labelEn, color, orderCount, revenue];
}

// ==========================================================================
// 💳 7. قسم مبيعات طرق الدفع (Payment Methods Breakdown)
// ==========================================================================
class AnalyticsPaymentBreakdownEntity extends Equatable {
  final String method;
  final int orderCount;
  final double revenue;
  final double sharePct;

  const AnalyticsPaymentBreakdownEntity({
    required this.method,
    required this.orderCount,
    required this.revenue,
    required this.sharePct,
  });

  @override
  List<Object?> get props => [method, orderCount, revenue, sharePct];
}