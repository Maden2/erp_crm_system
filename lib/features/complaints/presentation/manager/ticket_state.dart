import '../../domain/entities/ticket_entities.dart';

abstract class TicketState {}

class TicketInitial extends TicketState {}
class TicketLoading extends TicketState {}
class TicketDetailsLoading extends TicketState {}
class TicketStatusUpdating extends TicketState {}
class TestimonialCreating extends TicketState {}

class TicketSuccess extends TicketState {
  final List<TicketItemEntity>? tickets;
  final TicketStatsEntity? stats;
  final TicketDetailEntity? selectedTicket;
  final String? message; // لرسائل نجاح التحديث أو الإضافة

  TicketSuccess({
    this.tickets,
    this.stats,
    this.selectedTicket,
    this.message,
  });
}

class TicketError extends TicketState {
  final String message;
  TicketError(this.message);
}