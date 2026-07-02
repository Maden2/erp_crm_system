import 'live_order_item_entity.dart';
import 'live_order_status_meta_entity.dart';

class LiveOrderEntity {
  final String id;
  final String orderNumber;
  final int status;
  final String statusLabel;
  final LiveOrderStatusMetaEntity statusMeta;
  final double totalAmount;
  final double subTotal;
  final double discountTotal;
  final String paymentMethod;
  final DateTime orderDate;
  final String customerName;
  final String customerEmail;
  final int itemCount;
  final String shippingAddressCity;
  final String shippingAddressCountry;

  // حقول إضافية بتيجي في الـ Details فقط (nullable عشان شاشة الـ List متضربش)
  final String? customerNote;
  final String? phoneNumber;
  final List<LiveOrderItemEntity>? items;

  const LiveOrderEntity({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.statusLabel,
    required this.statusMeta,
    required this.totalAmount,
    required this.subTotal,
    required this.discountTotal,
    required this.paymentMethod,
    required this.orderDate,
    required this.customerName,
    required this.customerEmail,
    required this.itemCount,
    required this.shippingAddressCity,
    required this.shippingAddressCountry,
    this.customerNote,
    this.phoneNumber,
    this.items,
  });
}