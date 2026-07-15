class ClientStatsEntity {
  final int totalCustomers;
  final String growthRate;
  final int activeCustomers;
  final String activePercentage;

  const ClientStatsEntity({
    required this.totalCustomers,
    required this.growthRate,
    required this.activeCustomers,
    required this.activePercentage,
  });
}

class ClientListItemEntity {
  final String id;
  final String name;
  final int ordersCount;
  final double totalSpent;
  final String? logoUrl;

  const ClientListItemEntity({
    required this.id,
    required this.name,
    required this.ordersCount,
    required this.totalSpent,
    this.logoUrl,
  });
}

class ClientOrderHistoryEntity {
  final String orderId;
  final String date;
  final double amount;
  final String statusLabel;

  const ClientOrderHistoryEntity({
    required this.orderId,
    required this.date,
    required this.amount,
    required this.statusLabel,
  });
}

class ClientDetailEntity {
  final String id;
  final String name;
  final bool isActive;
  final String phone;
  final String email;
  final String registrationDate;
  final double rating;
  final String? note;
  final int totalOrders;
  final double totalSpending;
  final double averageOrderValue;
  final List<ClientOrderHistoryEntity> orders;

  const ClientDetailEntity({
    required this.id,
    required this.name,
    required this.isActive,
    required this.phone,
    required this.email,
    required this.registrationDate,
    required this.rating,
    this.note,
    required this.totalOrders,
    required this.totalSpending,
    required this.averageOrderValue,
    required this.orders,
  });
}