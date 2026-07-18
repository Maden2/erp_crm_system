import '../repositories/ticket_repository.dart';
import '../entities/ticket_entities.dart';

class GetTicketsListUseCase {
  final TicketRepository repository;
  GetTicketsListUseCase(this.repository);

  Future<Map<String, dynamic>> call({String? status, String? dateFilter, String? search}) async {
    return await repository.getComplaintsList(status: status, dateFilter: dateFilter, search: search);
  }
}

class GetTicketDetailsUseCase {
  final TicketRepository repository;
  GetTicketDetailsUseCase(this.repository);

  Future<TicketDetailEntity> call(String id) async {
    return await repository.getComplaintDetails(id);
  }
}

class UpdateTicketStatusUseCase {
  final TicketRepository repository;
  UpdateTicketStatusUseCase(this.repository);

  Future<void> call(String id, String status) async {
    await repository.updateComplaintStatus(id, status);
  }
}

class CreateTestimonialUseCase {
  final TicketRepository repository;
  CreateTestimonialUseCase(this.repository);

  Future<void> call({required String name, required int rating, required String comment}) async {
    await repository.createTestimonial(name, rating, comment);
  }
}