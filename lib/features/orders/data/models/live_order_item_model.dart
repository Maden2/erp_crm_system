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
      // 🟢 تأمين تحويل الحقول النصية حتى لو الباكيند غير نوعها أو بعتها Null
      productNameSnapshot: json['ProductNameSnapshot']?.toString() ?? '',
      quantity: json['Quantity'] ?? 0,
      unitPrice: (json['UnitPrice'] ?? 0 as num).toDouble(),
      discountAmount: (json['DiscountAmount'] ?? 0 as num).toDouble(),
      finalPrice: (json['FinalPrice'] ?? 0 as num).toDouble(),
      appliedOfferName: json['AppliedOfferName']?.toString(),

      // 🟢 القضاء على الكراش: تحويل آمن للـ Sku لو جاي Null بياخد String فاضي مأمن
      sku: json['Sku']?.toString() ?? '',
      primaryImage: json['PrimaryImage']?.toString(),
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