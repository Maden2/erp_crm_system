class DashboardLowStockEntity {
  final String id;
  final String name;
  final String sku;
  final num quantity;
  final String category;
  final String warehouse;
  final num salePrice;
  final bool isOutOfStock;
  final String? image;

  const DashboardLowStockEntity({
    required this.id,
    required this.name,
    required this.sku,
    required this.quantity,
    required this.category,
    required this.warehouse,
    required this.salePrice,
    required this.isOutOfStock,
    this.image,
  });
}