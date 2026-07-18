import '../entities/ticket_entities.dart';

abstract class TicketRepository {
  Future<Map<String, dynamic>> getComplaintsList({String? status, String? dateFilter, String? search});
  Future<TicketDetailEntity> getComplaintDetails(String id);
  Future<void> updateComplaintStatus(String id, String status);
  Future<void> createTestimonial(String customerName, int rating, String comment);
}