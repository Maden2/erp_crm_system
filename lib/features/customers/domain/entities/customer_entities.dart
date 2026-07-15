
class CustomerListEntity {
  final int totalCount;
  final int activeCount;
  final List<CustomerItemEntity> customers;

  const CustomerListEntity({
    required this.totalCount,
    required this.activeCount,
    required this.customers,
  });
}

class CustomerItemEntity {
  final String id;
  final String name;
  final int orderCount;
  final double totalSpending;
  final String? logoUrl;
  final bool isCompany;

  const CustomerItemEntity({
    required this.id,
    required this.name,
    required this.orderCount,
    required this.totalSpending,
    this.logoUrl,
    required this.isCompany,
  });
}

class CustomerDetailEntity {
  final String id;
  final String name;
  final String typeLabel; // فرد / مؤسسة
  final int totalOrders;
  final double totalPurchases;
  final double averageOrderValue;
  final double rating;
  final String phone;
  final String email;
  final String registrationDate;
  final String deliveryNotes;
  final List<CustomerOrderEntity> orderHistory;

  const CustomerDetailEntity({
    required this.id,
    required this.name,
    required this.typeLabel,
    required this.totalOrders,
    required this.totalPurchases,
    required this.averageOrderValue,
    required this.rating,
    required this.phone,
    required this.email,
    required this.registrationDate,
    required this.deliveryNotes,
    required this.orderHistory,
  });
}

class CustomerOrderEntity {
  final String orderId;
  final String orderNumber;
  final String date;
  final double amount;
  final String statusLabel;

  const CustomerOrderEntity({
    required this.orderId,
    required this.orderNumber,
    required this.date,
    required this.amount,
    required this.statusLabel,
  });
}