class LowStockEntity {
  final String id;
  final String productName;
  final String categoryName;
  final int remainingQuantity;
  final String imageUrl;

  LowStockEntity({
    required this.id,
    required this.productName,
    required this.categoryName,
    required this.remainingQuantity,
    required this.imageUrl,
  });
}
