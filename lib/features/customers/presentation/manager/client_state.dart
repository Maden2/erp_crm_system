import '../../domain/entities/client_entities.dart';

abstract class ClientState {}

class ClientInitial extends ClientState {}
class ClientLoading extends ClientState {}
class ClientDetailsLoading extends ClientState {}

class ClientSuccess extends ClientState {
  final List<ClientListItemEntity>? clients; // 🟢 جعلها Nullable لأمان شاشة التفاصيل
  final ClientStatsEntity? stats;             // 🟢 جعلها Nullable لأمان شاشة التفاصيل
  final ClientDetailEntity? selectedClient;

  ClientSuccess({
    this.clients,
    this.stats,
    this.selectedClient,
  });
}

class ClientError extends ClientState {
  final String message;
  ClientError(this.message);
}