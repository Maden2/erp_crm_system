import '../../domain/entities/profit_entity.dart';

class ProfitModel extends ProfitEntity {
  const ProfitModel({
    required super.monthlyProfit,
    required super.profitMarginPct,
  });

  factory ProfitModel.fromJson(Map<String, dynamic> json) {
    return ProfitModel(
      monthlyProfit: (json['monthlyProfit'] ?? 0).toDouble(),
      profitMarginPct: (json['profitMarginPct'] ?? 0).toDouble(),
    );
  }
}