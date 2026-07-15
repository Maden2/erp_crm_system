import '../entities/client_entities.dart';
import '../repositories/client_repository.dart';

class GetClientDetailsUseCase {
  final ClientRepository repository;

  GetClientDetailsUseCase(this.repository);

  Future<ClientDetailEntity> call(String id) async {
    return await repository.getCustomerDetails(id);
  }
}