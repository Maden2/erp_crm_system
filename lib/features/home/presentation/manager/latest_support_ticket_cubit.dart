import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/latest_support_ticket_entity.dart';
import '../../domain/usecases/get_latest_support_ticket_usecas.dart';

part 'latest_support_ticket_state.dart';

class LatestSupportTicketCubit extends Cubit<LatestSupportTicketState> {
  final GetLatestSupportTicketUseCase useCase;

  LatestSupportTicketCubit(this.useCase)
      : super(LatestSupportTicketInitial());

  Future<void> getLatestTicket() async {
    emit(LatestSupportTicketLoading());

    try {
      final ticket = await useCase.call();
      emit(LatestSupportTicketSuccess(ticket));
    } catch (e) {
      emit(LatestSupportTicketError(e.toString()));
    }
  }
}