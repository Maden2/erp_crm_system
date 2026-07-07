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
    List<LiveOrderItemModel>? super.items,
  });

  factory LiveOrderModel.fromJson(Map<String, dynamic> json) {
    return LiveOrderModel(
      id: json['Id'] ?? '',
      orderNumber: json['OrderNumber'] ?? '',
      status: json['Status'] ?? 0,
      statusLabel: json['StatusLabel'] ?? '',
      statusMeta: LiveOrderStatusMetaModel.fromJson(json['StatusMeta'] ?? {}),
      totalAmount: (json['TotalAmount'] ?? 0 as num).toDouble(),
      subTotal: (json['SubTotal'] ?? 0 as num).toDouble(),
      discountTotal: (json['DiscountTotal'] ?? 0 as num).toDouble(),
      paymentMethod: (json['PaymentMethod'] ?? '').toString(),
      orderDate: DateTime.parse(json['OrderDate'] ?? DateTime.now().toIso8601String()),

      // 🟢 الحل السحري لتأمين حقل اسم العميل: لو راجع لستة بياخد أول عنصر، لو نص عادي بيحوله String بأمان
      customerName: json['CustomerName'] is List
          ? (json['CustomerName'] as List).first.toString()
          : (json['CustomerName'] ?? '').toString(),

      customerEmail: json['CustomerEmail'] ?? '',
      itemCount: json['ItemCount'] ?? 0,
      shippingAddressCity: json['ShippingAddress_City'] ?? '',
      shippingAddressCountry: json['ShippingAddress_Country'] ?? '',

      // 🟢 تأمين إضافي للحقول دي لو الباكيند باعتها بأسماء مختلفة في ريكويست التفاصيل
      customerNote: (json['CustomerNote'] ?? json['Notes'])?.toString(),
      phoneNumber: (json['PhoneNumber'] ?? json['CustomerPhone'] ?? json['ShippingAddress_Phone'])?.toString(),

      items: json['items'] != null
          ? (json['items'] as List)
          .map((item) => LiveOrderItemModel.fromJson(item as Map<String, dynamic>))
          .toList()
          : null,
    );
  }
}