import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_client_details_usecase.dart';
import '../../domain/usecases/get_client_stats_usecase.dart';
import '../../domain/usecases/get_clients_list_usecase.dart';
import 'client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  final GetClientStatsUseCase getClientStatsUseCase;
  final GetClientsListUseCase getClientsListUseCase;
  final GetClientDetailsUseCase getClientDetailsUseCase;

  ClientCubit({
    required this.getClientStatsUseCase,
    required this.getClientsListUseCase,
    required this.getClientDetailsUseCase,
  }) : super(ClientInitial());

  Future<void> fetchClients({String? search, String? ordersLevel}) async {
    emit(ClientLoading());
    try {
      final stats = await getClientStatsUseCase();
      final clients = await getClientsListUseCase(search: search, ordersLevel: ordersLevel);

      emit(ClientSuccess(
        clients: clients,
        stats: stats,
      ));
    } catch (e) {
      emit(ClientError(e.toString()));
    }
  }

  Future<void> fetchClientDetails(String id) async {
    emit(ClientDetailsLoading());
    try {
      final details = await getClientDetailsUseCase(id);

      // 🟢 نرسل التفاصيل مباشرة، والـ UI لن يواجه أي تعارض مع الـ null
      emit(ClientSuccess(
        selectedClient: details,
      ));
    } catch (e) {
      emit(ClientError(e.toString()));
    }
  }
}