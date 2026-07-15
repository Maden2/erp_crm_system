class ComplaintListContainerEntity {
  final int totalCount;
  final int openCount;
  final int closedCount;
  final int closeRatePercent;
  final List<ComplaintItemEntity> complaints;

  const ComplaintListContainerEntity({
    required this.totalCount,
    required this.openCount,
    required this.closedCount,
    required this.closeRatePercent,
    required this.complaints,
  });
}

class ComplaintItemEntity {
  final String id;
  final String customerName;
  final String title;
  final String date;
  final String statusLabel; // مفتوحة - مغلقة

  const ComplaintItemEntity({
    required this.id,
    required this.customerName,
    required this.title,
    required this.date,
    required this.statusLabel,
  });
}

class ComplaintDetailEntity {
  final ComplaintItemEntity infoCard;
  final String fullDescription;
  final String orderNumber;
  final String productName;
  final String orderDate;

  const ComplaintDetailEntity({
    required this.infoCard,
    required this.fullDescription,
    required this.orderNumber,
    required this.productName,
    required this.orderDate,
  });
}