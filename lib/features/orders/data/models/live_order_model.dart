import '../../domain/entities/live_order_entity.dart';
import 'live_order_item_model.dart';
import 'live_order_status_meta_model.dart';

class LiveOrderModel extends LiveOrderEntity {
  const LiveOrderModel({
    required super.id,
    required super.orderNumber,
    required super.status,
    required super.statusLabel,
    required super.statusMeta,
    required super.totalAmount,
    required super.subTotal,
    required super.discountTotal,
    required super.paymentMethod,
    required super.orderDate,
    required super.customerName,
    required super.customerEmail,
    required super.itemCount,
    required super.shippingAddressCity,
    required super.shippingAddressCountry,
    super.customerNote,
    super.phoneNumber,
    List<LiveOrderItemModel>? super.items, // كـ Model جوه الـ Data Layer
  });

  factory LiveOrderModel.fromJson(Map<String, dynamic> json) {
    return LiveOrderModel(
      id: json['Id'] as String,
      orderNumber: json['OrderNumber'] as String,
      status: json['Status'] as int,
      statusLabel: json['StatusLabel'] as String,
      statusMeta: LiveOrderStatusMetaModel.fromJson(json['StatusMeta'] as Map<String, dynamic>),
      totalAmount: (json['TotalAmount'] as num).toDouble(),
      subTotal: (json['SubTotal'] as num).toDouble(),
      discountTotal: (json['DiscountTotal'] as num).toDouble(),
      paymentMethod: json['PaymentMethod'] as String,
      orderDate: DateTime.parse(json['OrderDate'] as String),
      customerName: json['CustomerName'] as String,
      customerEmail: json['CustomerEmail'] as String,
      itemCount: json['ItemCount'] as int,
      shippingAddressCity: json['ShippingAddress_City'] as String,
      shippingAddressCountry: json['ShippingAddress_Country'] as String,
      customerNote: json['CustomerNote'] as String?,
      phoneNumber: json['PhoneNumber'] as String?,
      items: json['items'] != null
          ? (json['items'] as List)
          .map((item) => LiveOrderItemModel.fromJson(item as Map<String, dynamic>))
          .toList()
          : null,
    );
  }
}