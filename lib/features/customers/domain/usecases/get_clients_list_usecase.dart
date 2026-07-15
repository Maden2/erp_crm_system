import '../entities/client_entities.dart';
import '../repositories/client_repository.dart';

class GetClientsListUseCase {
  final ClientRepository repository;

  GetClientsListUseCase(this.repository);

  Future<List<ClientListItemEntity>> call({String? search, String? ordersLevel}) async {
    return await repository.getClientsList(search: search, ordersLevel: ordersLevel);
  }
}