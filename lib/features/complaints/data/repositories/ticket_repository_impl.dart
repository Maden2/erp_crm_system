import '../../domain/repositories/ticket_repository.dart';
import '../../domain/entities/ticket_entities.dart';
import '../datasources/ticket_remote_data_source.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource remoteDataSource;

  TicketRepositoryImpl(this.remoteDataSource);

  @override
  Future<Map<String, dynamic>> getComplaintsList({String? status, String? dateFilter, String? search}) async {
    return await remoteDataSource.getComplaintsList(status: status, dateFilter: dateFilter, search: search);
  }

  @override
  Future<TicketDetailEntity> getComplaintDetails(String id) async {
    return await remoteDataSource.getComplaintDetails(id);
  }

  @override
  Future<void> updateComplaintStatus(String id, String status) async {
    await remoteDataSource.updateComplaintStatus(id, status);
  }

  @override
  Future<void> createTestimonial(String customerName, int rating, String comment) async {
    await remoteDataSource.createTestimonial(customerName, rating, comment);
  }
}