import '../entities/latest_support_ticket_entity.dart';
import '../repositories/home_repository.dart';

class GetLatestSupportTicketUseCase {
  final HomeRepository repository;

  GetLatestSupportTicketUseCase(this.repository);

  Future<LatestSupportTicketEntity?> call() async {
    final result = await repository.getLatestSupportTicket();

    return result.fold(
          (failure) => throw Exception(failure.message),
          (data) => data,
    );
  }
}