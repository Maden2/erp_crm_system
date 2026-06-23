import 'package:equatable/equatable.dart';
import 'order_item_entity.dart';

class OrderEntity extends Equatable {
  final String id;
  final String orderNumber;

  // ================= CUSTOMER =================
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final String shippingAddress;

  // ================= DATE =================
  final DateTime date;

  // ================= ORDER PRODUCTS =================
  final List<OrderItemEntity> items;
  final int itemsCount;

  // ================= ORDER SUMMARY =================
  final double subTotal;
  final double shippingFees;
  final double tax;
  final double discount;
  final double totalAmount;

  // ================= ORDER STATUS =================
  final String status;

  // ================= PAYMENT =================
  final String paymentMethod;
  final String paymentStatus;
  final String invoiceNumber;

  // ================= SHIPPING =================
  final String shippingCompany;
  final String trackingNumber;
  final String deliveryStatus;

  // ================= NOTES =================
  final String staffNotes;

  const OrderEntity({
    required this.id,
    required this.orderNumber,

    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.shippingAddress,

    required this.date,

    required this.items,
    required this.itemsCount,

    required this.subTotal,
    required this.shippingFees,
    required this.tax,
    required this.discount,
    required this.totalAmount,

    required this.status,

    required this.paymentMethod,
    required this.paymentStatus,
    required this.invoiceNumber,

    required this.shippingCompany,
    required this.trackingNumber,
    required this.deliveryStatus,

    required this.staffNotes,
  });

  @override
  List<Object?> get props => [id, orderNumber, status, totalAmount];
}
