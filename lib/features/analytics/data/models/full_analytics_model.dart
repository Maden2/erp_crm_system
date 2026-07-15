import '../../domain/entities/full_analytics_entity.dart';

class FullAnalyticsModel extends FullAnalyticsEntity {
  const FullAnalyticsModel({
    required super.overview,
    required super.profit,
    required super.salesChart,
    required super.topProducts,
    required super.categories,
    required super.statusBreakdown,
    required super.paymentBreakdown,
  });

  factory FullAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return FullAnalyticsModel(
      overview: AnalyticsOverviewModel.fromJson(json['overview'] ?? {}),
      profit: AnalyticsProfitModel.fromJson(json['profit'] ?? {}),
      salesChart: AnalyticsSalesChartModel.fromJson(json['salesChart'] ?? {}),
      topProducts: json['topProducts'] != null
          ? (json['topProducts'] as List)
          .map((item) => AnalyticsProductModel.fromJson(item as Map<String, dynamic>))
          .toList()
          : [],
      categories: json['categories'] != null
          ? (json['categories'] as List)
          .map((item) => AnalyticsCategoryModel.fromJson(item as Map<String, dynamic>))
          .toList()
          : [],
      statusBreakdown: json['statusBreakdown'] != null
          ? (json['statusBreakdown'] as List)
          .map((item) => AnalyticsStatusBreakdownModel.fromJson(item as Map<String, dynamic>))
          .toList()
          : [],
      paymentBreakdown: json['paymentBreakdown'] != null
          ? (json['paymentBreakdown'] as List)
          .map((item) => AnalyticsPaymentBreakdownModel.fromJson(item as Map<String, dynamic>))
          .toList()
          : [],
    );
  }
}

// ==========================================================================
// 📊 1. Overview Model
// ==========================================================================
class AnalyticsOverviewModel extends AnalyticsOverviewEntity {
  const AnalyticsOverviewModel({
    required super.period,
    required super.revenue,
    required super.orders,
    required super.averageOrderValue,
    required super.allTime,
  });

  factory AnalyticsOverviewModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsOverviewModel(
      period: json['period'] ?? 'daily',
      revenue: AnalyticsMetricModel.fromJson(json['revenue'] ?? {}),
      orders: AnalyticsOrdersMetricModel.fromJson(json['orders'] ?? {}),
      averageOrderValue: AnalyticsMetricModel.fromJson(json['averageOrderValue'] ?? {}),
      allTime: AnalyticsAllTimeModel.fromJson(json['allTime'] ?? {}),
    );
  }
}

class AnalyticsMetricModel extends AnalyticsMetricEntity {
  const AnalyticsMetricModel({
    required super.current,
    required super.previous,
    required super.changePercent,
    required super.trend,
  });

  factory AnalyticsMetricModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsMetricModel(
      current: (json['current'] ?? 0.0 as num).toDouble(),
      previous: (json['previous'] ?? 0.0 as num).toDouble(),
      changePercent: (json['changePercent'] ?? 0.0 as num).toDouble(),
      trend: json['trend'] ?? 'up',
    );
  }
}

class AnalyticsOrdersMetricModel extends AnalyticsOrdersMetricEntity {
  const AnalyticsOrdersMetricModel({
    required super.current,
    required super.previous,
    required super.changePercent,
    required super.trend,
  });

  factory AnalyticsOrdersMetricModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsOrdersMetricModel(
      current: json['current'] ?? 0,
      previous: json['previous'] ?? 0,
      changePercent: (json['changePercent'] ?? 0.0 as num).toDouble(),
      trend: json['trend'] ?? 'up',
    );
  }
}

class AnalyticsAllTimeModel extends AnalyticsAllTimeEntity {
  const AnalyticsAllTimeModel({
    required super.revenue,
    required super.orders,
  });

  factory AnalyticsAllTimeModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsAllTimeModel(
      revenue: (json['revenue'] ?? 0.0 as num).toDouble(),
      orders: json['orders'] ?? 0,
    );
  }
}

// ==========================================================================
// 💰 2. Profit Model
// ==========================================================================
class AnalyticsProfitModel extends AnalyticsProfitEntity {
  const AnalyticsProfitModel({
    required super.period,
    required super.revenue,
    required super.cogs,
    required super.grossProfit,
    required super.profitMarginPct,
  });

  factory AnalyticsProfitModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsProfitModel(
      period: json['period'] ?? 'monthly',
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      cogs: (json['cogs'] as num?)?.toDouble() ?? 0.0,
      grossProfit: (json['grossProfit'] as num?)?.toDouble() ?? 0.0,
      profitMarginPct: (json['profitMarginPct'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

// ==========================================================================
// 📈 3. Sales Chart Model
// ==========================================================================
class AnalyticsSalesChartModel extends AnalyticsSalesChartEntity {
  const AnalyticsSalesChartModel({
    required super.period,
    required super.chart,
    required super.isFallback,
  });

  factory AnalyticsSalesChartModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsSalesChartModel(
      period: json['period'] ?? 'daily',
      isFallback: json['isFallback'] ?? false,
      chart: json['chart'] != null
          ? (json['chart'] as List)
          .map((item) => AnalyticsChartPointModel.fromJson(item as Map<String, dynamic>))
          .toList()
          : [],
    );
  }
}

class AnalyticsChartPointModel extends AnalyticsChartPointEntity {
  const AnalyticsChartPointModel({
    required super.date,
    required super.ordersCount,
    required super.revenue,
    required super.aov,
    required super.isFallback,
  });

  factory AnalyticsChartPointModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsChartPointModel(
      date: json['date'] ?? json['day'] ?? '',
      ordersCount: json['ordersCount'] ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      aov: (json['aov'] as num?)?.toDouble() ?? 0.0,
      isFallback: json['isFallback'] ?? false,
    );
  }
}

// ==========================================================================
// 📦 4. Top Products Model
// ==========================================================================
class AnalyticsProductModel extends AnalyticsProductEntity {
  const AnalyticsProductModel({
    required super.rank,
    required super.productName,
    required super.sku,
    required super.unitsSold,
    required super.revenue,
    required super.avgPrice,
    required super.image,
  });

  factory AnalyticsProductModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsProductModel(
      rank: json['rank'] ?? 0,
      productName: json['productName'] ?? '',
      sku: json['sku'] ?? '',
      unitsSold: json['unitsSold'] ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      avgPrice: (json['avgPrice'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] ?? '',
    );
  }
}

// ==========================================================================
// 🏷️ 5. Categories Model
// ==========================================================================
class AnalyticsCategoryModel extends AnalyticsCategoryEntity {
  const AnalyticsCategoryModel({
    required super.category,
    required super.unitsSold,
    required super.revenue,
    required super.sharePct,
  });

  factory AnalyticsCategoryModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsCategoryModel(
      category: json['category'] ?? 'غير مصنف',
      unitsSold: json['unitsSold'] ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      sharePct: (json['sharePct'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

// ==========================================================================
// 🍩 6. Status Breakdown Model
// ==========================================================================
class AnalyticsStatusBreakdownModel extends AnalyticsStatusBreakdownEntity {
  const AnalyticsStatusBreakdownModel({
    required super.status,
    required super.label,
    required super.labelEn,
    required super.color,
    required super.orderCount,
    required super.revenue,
  });

  factory AnalyticsStatusBreakdownModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsStatusBreakdownModel(
      status: json['status'] ?? 0,
      label: json['label'] ?? '',
      labelEn: json['labelEn'] ?? '',
      color: json['color'] ?? '#Grey',
      orderCount: json['orderCount'] ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

// ==========================================================================
// 💳 7. Payment Breakdown Model
// ==========================================================================
class AnalyticsPaymentBreakdownModel extends AnalyticsPaymentBreakdownEntity {
  const AnalyticsPaymentBreakdownModel({
    required super.method,
    required super.orderCount,
    required super.revenue,
    required super.sharePct,
  });

  factory AnalyticsPaymentBreakdownModel.fromJson(Map<String, dynamic> json) {
    String methodLabel = "unknown";
    if (json['methodName'] != null) {
      methodLabel = json['methodName'].toString();
    } else if (json['method'] != null) {
      methodLabel = json['method'].toString() == "0" ? "كاش" : "بطاقة بنكية";
    }

    return AnalyticsPaymentBreakdownModel(
      method: methodLabel,
      orderCount: json['orderCount'] ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      sharePct: (json['sharePct'] as num?)?.toDouble() ?? 0.0,
    );
  }
}