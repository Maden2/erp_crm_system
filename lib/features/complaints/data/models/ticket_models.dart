import '../../domain/entities/ticket_entities.dart';

class TicketStatsModel extends TicketStatsEntity {
  const TicketStatsModel({
    required super.totalComplaints,
    required super.openComplaints,
    required super.closedComplaints,
    required super.activePercentage,
  });

  factory TicketStatsModel.fromJson(Map<String, dynamic> json) {
    return TicketStatsModel(
      totalComplaints: json['totalComplaints'] ?? 0,
      openComplaints: json['openComplaints'] ?? 0,
      closedComplaints: json['closedComplaints'] ?? 0,
      activePercentage: json['activePercentage'] ?? "0%",
    );
  }
}

class TicketItemModel extends TicketItemEntity {
  const TicketItemModel({
    required super.id,
    required super.customerName,
    required super.title,
    required super.status,
    required super.date,
    required super.rating,
  });

  factory TicketItemModel.fromJson(Map<String, dynamic> json) {
    return TicketItemModel(
      id: json['id']?.toString() ?? '',
      customerName: json['customerName'] ?? json['customer'] ?? '',
      title: json['title'] ?? json['subject'] ?? '',
      status: json['status'] ?? 'open',
      date: json['date'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class TicketDetailModel extends TicketDetailEntity {
  const TicketDetailModel({
    required super.id,
    required super.customerName,
    required super.title,
    required super.status,
    required super.date,
    required super.complaintText,
    required super.orderNumber,
    required super.productName,
    required super.orderDate,
  });

  factory TicketDetailModel.fromJson(Map<String, dynamic> json) {
    final orderMeta = json['orderMeta'] as Map<String, dynamic>? ?? {};

    return TicketDetailModel(
      id: json['id']?.toString() ?? '',
      customerName: json['customerName'] ?? '',
      title: json['title'] ?? '',
      status: json['status'] ?? 'open',
      date: json['date'] ?? '',
      complaintText: json['complaintText'] ?? json['description'] ?? '',
      orderNumber: orderMeta['orderNumber'] ?? json['orderNumber'] ?? '#00000',
      productName: orderMeta['productName'] ?? json['productName'] ?? '',
      orderDate: orderMeta['orderDate'] ?? json['orderDate'] ?? '',
    );
  }
}