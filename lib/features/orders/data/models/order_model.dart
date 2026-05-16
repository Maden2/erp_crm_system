import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_item_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.orderNumber,
    required super.customerName,
    required super.customerPhone,
    required super.customerEmail,
    required super.shippingAddress,
    required super.date,
    required super.items,
    required super.itemsCount,
    required super.subTotal,
    required super.shippingFees,
    required super.tax,
    required super.discount,
    required super.totalAmount,
    required super.status,
    required super.paymentMethod,
    required super.paymentStatus,
    required super.invoiceNumber,
    required super.shippingCompany,
    required super.trackingNumber,
    required super.deliveryStatus,
    required super.staffNotes,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id']?.toString() ?? "",
      orderNumber: json['order_number'] ?? "",
      customerName: json['customer_name'] ?? "",
      customerPhone: json['customer_phone'] ?? "",
      customerEmail: json['customer_email'] ?? "",
      shippingAddress: json['shipping_address'] ?? "",
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),

      items: (json['items'] as List?)
          ?.map((item) => OrderItemModel.fromJson(item))
          .toList() ?? [],

      itemsCount: json['items_count'] ?? 0,
      subTotal: (json['sub_total'] as num?)?.toDouble() ?? 0.0,
      shippingFees: (json['shipping_fees'] as num?)?.toDouble() ?? 0.0,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? "",
      paymentMethod: json['payment_method'] ?? "",
      paymentStatus: json['payment_status'] ?? "",
      invoiceNumber: json['invoice_number'] ?? "",
      shippingCompany: json['shipping_company'] ?? "",
      trackingNumber: json['tracking_number'] ?? "",
      deliveryStatus: json['delivery_status'] ?? "",
      staffNotes: json['staff_notes'] ?? "",
    );
  }
}

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.name,
    required super.image,
    required super.quantity,
    required super.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id']?.toString() ?? "",
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      quantity: json['quantity'] ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}