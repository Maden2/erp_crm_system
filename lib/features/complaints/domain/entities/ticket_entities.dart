import 'package:equatable/equatable.dart';

class TicketStatsEntity extends Equatable {
  final int totalComplaints;
  final int openComplaints;
  final int closedComplaints;
  final String activePercentage;

  const TicketStatsEntity({
    required this.totalComplaints,
    required this.openComplaints,
    required this.closedComplaints,
    required this.activePercentage,
  });

  @override
  List<Object?> get props => [totalComplaints, openComplaints, closedComplaints, activePercentage];
}

class TicketItemEntity extends Equatable {
  final String id;
  final String customerName;
  final String title;
  final String status;
  final String date;
  final double rating;

  const TicketItemEntity({
    required this.id,
    required this.customerName,
    required this.title,
    required this.status,
    required this.date,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, customerName, title, status, date, rating];
}

class TicketDetailEntity extends Equatable {
  final String id;
  final String customerName;
  final String title;
  final String status;
  final String date;
  final String complaintText;
  final String orderNumber;
  final String productName;
  final String orderDate;

  const TicketDetailEntity({
    required this.id,
    required this.customerName,
    required this.title,
    required this.status,
    required this.date,
    required this.complaintText,
    required this.orderNumber,
    required this.productName,
    required this.orderDate,
  });

  @override
  List<Object?> get props => [
    id,
    customerName,
    title,
    status,
    date,
    complaintText,
    orderNumber,
    productName,
    orderDate,
  ];
}