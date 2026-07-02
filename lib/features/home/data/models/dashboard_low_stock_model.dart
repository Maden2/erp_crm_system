import '../../domain/entities/dashboard_low_stock_entity.dart';

class DashboardLowStockModel extends DashboardLowStockEntity {
  const DashboardLowStockModel({
    required super.id,
    required super.name,
    required super.sku,
    required super.quantity,
    required super.category,
    required super.warehouse,
    required super.salePrice,
    required super.isOutOfStock,
    super.image,
  });

  factory DashboardLowStockModel.fromJson(Map<String, dynamic> json) {
    return DashboardLowStockModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      sku: json['sku'] ?? '',
      quantity: json['quantity'] ?? 0,
      category: json['category'] ?? '',
      warehouse: json['warehouse'] ?? '',
      salePrice: (json['salePrice'] ?? 0).toDouble(),
      isOutOfStock: json['isOutOfStock'] ?? false,
      image: json['image'],
    );
  }
}