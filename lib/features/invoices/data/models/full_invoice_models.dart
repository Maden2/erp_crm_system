import '../../domain/entities/full_invoice_entities.dart';

// ==========================================================================
// 1. موديل كائن الفاتورة الفردي (القايمة والتفاصيل المدمجة)
// ==========================================================================
class FullInvoiceModel extends FullInvoiceDetailEntity {
  const FullInvoiceModel({
    required super.id,
    required super.invoiceNumber,
    required super.status,
    required super.statusLabel,
    required super.statusBadge,
    required super.paymentMethod,
    required super.orderDate,
    required super.customer,
    required super.financials,
    required super.items,
  });

  factory FullInvoiceModel.fromJson(Map<String, dynamic> json) {
    return FullInvoiceModel(
      id: json['id'] ?? '',
      invoiceNumber: json['invoiceNumber'] ?? '',
      status: json['status'] ?? 0,
      statusLabel: json['statusLabel'] ?? '',
      statusBadge: json['statusBadge'] ?? '',

      // 🟢 تأمين الـ paymentMethod هنا أيضاً تحسباً لو جاءت int أو String في التفاصيل
      paymentMethod: json['paymentMethod'] is int
          ? (json['paymentMethod'] == 0 ? 'card' : json['paymentMethod'] == 1 ? 'cash' : 'transfer')
          : (json['paymentMethod'] ?? ''),

      orderDate: json['orderDate'] ?? '',
      customer: FullInvoiceCustomerModel.fromJson(json['customer'] ?? {}),
      financials: FullInvoiceFinancialsModel.fromJson(json['financials'] ?? {}),
      items: (json['items'] as List?)
          ?.map((i) => FullInvoiceLineItemModel.fromJson(i))
          .toList() ?? [],
    );
  }
}

// ==========================================================================
// 2. موديل قائمة الفواتير بالـ Pagination
// ==========================================================================
class FullInvoiceListModel extends FullInvoiceListEntity {
  const FullInvoiceListModel({
    required super.total,
    required super.page,
    required super.limit,
    required super.pages,
    required super.items,
  });

  factory FullInvoiceListModel.fromJson(Map<String, dynamic> json) {
    return FullInvoiceListModel(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 20,
      pages: json['pages'] ?? 1,
      items: (json['items'] as List?)
          ?.map((i) => FullInvoiceItemModel.fromJson(i))
          .toList() ?? [],
    );
  }
}

class FullInvoiceItemModel extends FullInvoiceItemEntity {
  const FullInvoiceItemModel({
    required super.id,
    required super.invoiceNumber,
    required super.status,
    required super.statusLabel,
    required super.statusBadge,
    required super.statusColor,
    required super.totalAmount,
    required super.paymentMethod,
    required super.orderDate,
    required super.customer,
    required super.itemCount,
  });

  factory FullInvoiceItemModel.fromJson(Map<String, dynamic> json) {
    return FullInvoiceItemModel(
      id: json['id'] ?? '',
      invoiceNumber: json['invoiceNumber'] ?? '',
      status: json['status'] ?? 0,
      statusLabel: json['statusLabel'] ?? '',
      statusBadge: json['statusBadge'] ?? '',
      statusColor: json['statusColor'] ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,

      // 🟢 تأمين الـ paymentMethod سواء جاءت int (0, 1) أو String من الـ API الحقيقي
      paymentMethod: json['paymentMethod'] is int
          ? (json['paymentMethod'] == 0 ? 'card' : json['paymentMethod'] == 1 ? 'cash' : 'transfer')
          : (json['paymentMethod'] ?? ''),

      orderDate: json['orderDate'] ?? '',
      customer: FullInvoiceCustomerModel.fromJson(json['customer'] ?? {}),
      itemCount: json['itemCount'] ?? 0,
    );
  }
}

// ==========================================================================
// 3. موديل الإحصائيات (Stats) حاسبين حساب كل البنود
// ==========================================================================
class FullInvoiceStatsModel extends FullInvoiceStatsEntity {
  const FullInvoiceStatsModel({
    required super.total,
    required super.totalRevenue,
    required super.byStatus,
  });

  factory FullInvoiceStatsModel.fromJson(Map<String, dynamic> json) {
    return FullInvoiceStatsModel(
      total: json['total'] ?? 0,
      totalRevenue: (json['totalRevenue'] as num?)?.toDouble() ?? 0.0,
      byStatus: (json['byStatus'] as List?)
          ?.map((s) => FullInvoiceStatusStatModel.fromJson(s))
          .toList() ?? [],
    );
  }
}

class FullInvoiceStatusStatModel extends FullInvoiceStatusStatEntity {
  const FullInvoiceStatusStatModel({
    required super.badge,
    required super.label,
    required super.orderCount,
    required super.revenue,
  });

  factory FullInvoiceStatusStatModel.fromJson(Map<String, dynamic> json) {
    return FullInvoiceStatusStatModel(
      badge: json['badge'] ?? '',
      label: json['label'] ?? '',
      orderCount: json['orderCount'] ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

// ==========================================================================
// 4. موديل تعريف الحالات للـ Filter Chips
// ==========================================================================
class FullInvoiceStatusDefinitionModel extends FullInvoiceStatusDefinitionEntity {
  const FullInvoiceStatusDefinitionModel({
    required super.badge,
    required super.label,
    required super.labelEn,
    required super.color,
    required super.bg,
  });

  factory FullInvoiceStatusDefinitionModel.fromJson(Map<String, dynamic> json) {
    return FullInvoiceStatusDefinitionModel(
      badge: json['badge'] ?? '',
      label: json['label'] ?? '',
      labelEn: json['labelEn'] ?? '',
      color: json['color'] ?? '',
      bg: json['bg'] ?? '',
    );
  }
}

// ==========================================================================
// 💎 الموديلات المساعدة العميقة (Customer, Financials, LineItem)
// ==========================================================================
class FullInvoiceCustomerModel extends FullInvoiceCustomerEntity {
  const FullInvoiceCustomerModel({required super.name, required super.email, super.phone});

  factory FullInvoiceCustomerModel.fromJson(Map<String, dynamic> json) {
    return FullInvoiceCustomerModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
    );
  }
}

class FullInvoiceFinancialsModel extends FullInvoiceFinancialsEntity {
  const FullInvoiceFinancialsModel({
    required super.subTotal,
    required super.discount,
    required super.taxRate,
    required super.taxAmount,
    required super.grandTotal,
  });

  factory FullInvoiceFinancialsModel.fromJson(Map<String, dynamic> json) {
    return FullInvoiceFinancialsModel(
      subTotal: (json['subTotal'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0.15,
      taxAmount: (json['taxAmount'] as num?)?.toDouble() ?? 0.0,
      grandTotal: (json['grandTotal'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class FullInvoiceLineItemModel extends FullInvoiceLineItemEntity {
  const FullInvoiceLineItemModel({
    required super.productName,
    required super.sku,
    required super.quantity,
    required super.unitPrice,
    required super.discountAmount,
    required super.finalPrice,
    super.offerApplied,
    required super.image,
  });

  factory FullInvoiceLineItemModel.fromJson(Map<String, dynamic> json) {
    return FullInvoiceLineItemModel(
      productName: json['productName'] ?? '',
      sku: json['sku'] ?? '',
      quantity: json['quantity'] ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0.0,
      finalPrice: (json['finalPrice'] as num?)?.toDouble() ?? 0.0,
      offerApplied: json['offerApplied'],
      image: json['image'] ?? '',
    );
  }
}