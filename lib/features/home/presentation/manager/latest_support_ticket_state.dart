part of 'latest_support_ticket_cubit.dart';

abstract class LatestSupportTicketState {}

class LatestSupportTicketInitial extends LatestSupportTicketState {}

class LatestSupportTicketLoading extends LatestSupportTicketState {}

class LatestSupportTicketSuccess extends LatestSupportTicketState {
  final LatestSupportTicketEntity? ticket;

  LatestSupportTicketSuccess(this.ticket);
}

class LatestSupportTicketError extends LatestSupportTicketState {
  final String message;

  LatestSupportTicketError(this.message);
}