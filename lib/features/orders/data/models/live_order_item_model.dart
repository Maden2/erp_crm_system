import '../../domain/entities/live_order_item_entity.dart';

class LiveOrderItemModel extends LiveOrderItemEntity {
  const LiveOrderItemModel({
    required super.productNameSnapshot,
    required super.quantity,
    required super.unitPrice,
    required super.discountAmount,
    required super.finalPrice,
    super.appliedOfferName,
    required super.sku,
    super.primaryImage,
  });

  factory LiveOrderItemModel.fromJson(Map<String, dynamic> json) {
    return LiveOrderItemModel(
      productNameSnapshot: json['ProductNameSnapshot'] as String,
      quantity: json['Quantity'] as int,
      unitPrice: (json['UnitPrice'] as num).toDouble(),
      discountAmount: (json['DiscountAmount'] as num).toDouble(),
      finalPrice: (json['FinalPrice'] as num).toDouble(),
      appliedOfferName: json['AppliedOfferName'] as String?,
      sku: json['Sku'] as String,
      primaryImage: json['PrimaryImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductNameSnapshot': productNameSnapshot,
      'Quantity': quantity,
      'UnitPrice': unitPrice,
      'DiscountAmount': discountAmount,
      'FinalPrice': finalPrice,
      'AppliedOfferName': appliedOfferName,
      'Sku': sku,
      'PrimaryImage': primaryImage,
    };
  }
}