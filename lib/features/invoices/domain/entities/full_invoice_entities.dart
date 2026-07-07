import 'package:equatable/equatable.dart';

// ==========================================================================
// 🏷️ 1. كيان تعريف الحالات (Status Definitions Filter Chips)
// ==========================================================================
class FullInvoiceStatusDefinitionEntity extends Equatable {
  final String badge;
  final String label;
  final String labelEn;
  final String color;
  final String bg;

  const FullInvoiceStatusDefinitionEntity({
    required this.badge,
    required this.label,
    required this.labelEn,
    required this.color,
    required this.bg,
  });

  @override
  List<Object?> get props => [badge, label, labelEn, color, bg];
}

// ==========================================================================
// 📊 2. كيان الإحصائيات المجمعة (Invoice Stats Overview)
// ==========================================================================
class FullInvoiceStatsEntity extends Equatable {
  final int total;
  final double totalRevenue;
  final List<FullInvoiceStatusStatEntity> byStatus;

  const FullInvoiceStatsEntity({
    required this.total,
    required this.totalRevenue,
    required this.byStatus,
  });

  @override
  List<Object?> get props => [total, totalRevenue, byStatus];
}

class FullInvoiceStatusStatEntity extends Equatable {
  final String badge;
  final String label;
  final int orderCount;
  final double revenue;

  const FullInvoiceStatusStatEntity({
    required this.badge,
    required this.label,
    required this.orderCount,
    required this.revenue,
  });

  @override
  List<Object?> get props => [badge, label, orderCount, revenue];
}

// ==========================================================================
// 📋 3. كيان قائمة الفواتير (Paginated Invoices List)
// ==========================================================================
class FullInvoiceListEntity extends Equatable {
  final int total;
  final int page;
  final int limit;
  final int pages;
  final List<FullInvoiceItemEntity> items;

  const FullInvoiceListEntity({
    required this.total,
    required this.page,
    required this.limit,
    required this.pages,
    required this.items,
  });

  @override
  List<Object?> get props => [total, page, limit, pages, items];
}

class FullInvoiceItemEntity extends Equatable {
  final String id;
  final String invoiceNumber;
  final int status;
  final String statusLabel;
  final String statusBadge;
  final String statusColor;
  final double totalAmount;
  final String paymentMethod;
  final String orderDate;
  final FullInvoiceCustomerEntity customer;
  final int itemCount;

  const FullInvoiceItemEntity({
    required this.id,
    required this.invoiceNumber,
    required this.status,
    required this.statusLabel,
    required this.statusBadge,
    required this.statusColor,
    required this.totalAmount,
    required this.paymentMethod,
    required this.orderDate,
    required this.customer,
    required this.itemCount,
  });

  @override
  List<Object?> get props => [
    id, invoiceNumber, status, statusLabel, statusBadge,
    statusColor, totalAmount, paymentMethod, orderDate, customer, itemCount,
  ];
}

// 🟢 كيان العميل المشترك بين اللستة والتفاصيل
class FullInvoiceCustomerEntity extends Equatable {
  final String name;
  final String email;
  final String? phone;

  const FullInvoiceCustomerEntity({
    required this.name,
    required this.email,
    this.phone,
  });

  @override
  List<Object?> get props => [name, email, phone];
}

// ==========================================================================
// 💎 4. كيان تفاصيل الفاتورة الكاملة (Full Invoice Detail Screen)
// ==========================================================================
class FullInvoiceDetailEntity extends Equatable {
  final String id;
  final String invoiceNumber;
  final int status;
  final String statusLabel;
  final String statusBadge;
  final String paymentMethod;
  final String orderDate;
  final FullInvoiceCustomerEntity customer;
  final FullInvoiceFinancialsEntity financials;
  final List<FullInvoiceLineItemEntity> items;

  const FullInvoiceDetailEntity({
    required this.id,
    required this.invoiceNumber,
    required this.status,
    required this.statusLabel,
    required this.statusBadge,
    required this.paymentMethod,
    required this.orderDate,
    required this.customer,
    required this.financials,
    required this.items,
  });

  @override
  List<Object?> get props => [
    id, invoiceNumber, status, statusLabel, statusBadge,
    paymentMethod, orderDate, customer, financials, items,
  ];
}

class FullInvoiceFinancialsEntity extends Equatable {
  final double subTotal;
  final double discount;
  final double taxRate;
  final double taxAmount;
  final double grandTotal;

  const FullInvoiceFinancialsEntity({
    required this.subTotal,
    required this.discount,
    required this.taxRate,
    required this.taxAmount,
    required this.grandTotal,
  });

  @override
  List<Object?> get props => [subTotal, discount, taxRate, taxAmount, grandTotal];
}

class FullInvoiceLineItemEntity extends Equatable {
  final String productName;
  final String sku;
  final int quantity;
  final double unitPrice;
  final double discountAmount;
  final double finalPrice;
  final String? offerApplied;
  final String image;

  const FullInvoiceLineItemEntity({
    required this.productName,
    required this.sku,
    required this.quantity,
    required this.unitPrice,
    required this.discountAmount,
    required this.finalPrice,
    this.offerApplied,
    required this.image,
  });

  @override
  List<Object?> get props => [
    productName, sku, quantity, unitPrice, discountAmount, finalPrice, offerApplied, image,
  ];
}