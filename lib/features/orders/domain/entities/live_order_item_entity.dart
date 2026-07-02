class LiveOrderItemEntity {
  final String productNameSnapshot;
  final int quantity;
  final double unitPrice;
  final double discountAmount;
  final double finalPrice;
  final String? appliedOfferName;
  final String sku;
  final String? primaryImage;

  const LiveOrderItemEntity({
    required this.productNameSnapshot,
    required this.quantity,
    required this.unitPrice,
    required this.discountAmount,
    required this.finalPrice,
    this.appliedOfferName,
    required this.sku,
    this.primaryImage,
  });
}