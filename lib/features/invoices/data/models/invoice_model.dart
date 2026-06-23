import '../../domain/entities/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity {
  const InvoiceModel({
    required super.invoiceNumber,
    required super.date,
    required super.status,
    required super.products,
    required super.paymentMethod,
    required super.subTotal,
    required super.tax,
    required super.totalAmount,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      invoiceNumber: json['invoice_number'] ?? '',
      date: json['date'] ?? '',
      status: _mapStatus(json['status']),
      subTotal: json['sub_total'] ?? '',
      tax: json['tax'] ?? '',
      totalAmount: json['total_amount'] ?? '',
      paymentMethod: PaymentMethodEntity(
        methodName: json['payment_method']?['name'] ?? '',
        paymentStatus: json['payment_method']?['status'] ?? '',
        isPaid: json['payment_method']?['is_paid'] ?? false,
      ),
      products: (json['products'] as List? ?? [])
          .map(
            (p) => InvoiceProductEntity(
              productName: p['name'] ?? '',
              quantity: p['quantity'] ?? 0,
              price: p['price'] ?? '',
            ),
          )
          .toList(),
    );
  }

  static InvoiceStatus _mapStatus(String? status) {
    switch (status) {
      case 'paid':
        return InvoiceStatus.paid;
      case 'unpaid':
        return InvoiceStatus.unpaid;
      case 'canceled':
        return InvoiceStatus.canceled;
      default:
        return InvoiceStatus.unpaid;
    }
  }
}
