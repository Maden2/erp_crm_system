import '../entities/client_entities.dart';
import '../repositories/client_repository.dart';

class GetClientStatsUseCase {
  final ClientRepository repository;

  GetClientStatsUseCase(this.repository);

  Future<ClientStatsEntity> call() async {
    return await repository.getClientStats();
  }
}