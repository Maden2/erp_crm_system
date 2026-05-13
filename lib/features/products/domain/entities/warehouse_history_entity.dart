class WarehouseHistoryEntity {
  final String id;
  final String userName;
  final String date;
  final int productsCount;
  final String category;

  WarehouseHistoryEntity({
    required this.id,
    required this.userName,
    required this.date,
    required this.productsCount,
    required this.category,
  });
}