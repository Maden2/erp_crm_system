import '../entities/client_entities.dart';

abstract class ClientRepository {
  Future<ClientStatsEntity> getClientStats();
  Future<List<ClientListItemEntity>> getClientsList({String? search, String? ordersLevel});
  Future<ClientDetailEntity> getCustomerDetails(String id);
}