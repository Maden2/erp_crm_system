class OrdersPaginationMetaEntity {
  final int total;
  final int page;
  final int limit;

  const OrdersPaginationMetaEntity({
    required this.total,
    required this.page,
    required this.limit,
  });
}