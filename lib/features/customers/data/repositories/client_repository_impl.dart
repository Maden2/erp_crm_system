import '../../domain/entities/client_entities.dart';
import '../../domain/repositories/client_repository.dart';
import '../datasources/client_remote_data_source.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientRemoteDataSource remoteDataSource;

  ClientRepositoryImpl(this.remoteDataSource);

  @override
  Future<ClientStatsEntity> getClientStats() => remoteDataSource.getClientStats();

  @override
  Future<List<ClientListItemEntity>> getClientsList({String? search, String? ordersLevel}) =>
      remoteDataSource.getClientsList(search: search, ordersLevel: ordersLevel);

  @override
  Future<ClientDetailEntity> getCustomerDetails(String id) => remoteDataSource.getClientDetails(id);
}