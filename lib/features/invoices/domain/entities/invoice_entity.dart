enum InvoiceStatus { paid, unpaid, canceled }

class InvoiceProductEntity {
  final String productName;
  final int quantity;
  final String price;

  const InvoiceProductEntity({
    required this.productName,
    required this.quantity,
    required this.price,
  });
}

class PaymentMethodEntity {
  final String methodName;
  final String paymentStatus;
  final bool isPaid;

  const PaymentMethodEntity({
    required this.methodName,
    required this.paymentStatus,
    required this.isPaid,
  });
}

class InvoiceEntity {
  final String invoiceNumber;
  final String date;
  final InvoiceStatus status;
  final List<InvoiceProductEntity> products;
  final PaymentMethodEntity paymentMethod;
  final String subTotal;
  final String tax;
  final String totalAmount;

  const InvoiceEntity({
    required this.invoiceNumber,
    required this.date,
    required this.status,
    required this.products,
    required this.paymentMethod,
    required this.subTotal,
    required this.tax,
    required this.totalAmount,
  });
}
