import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_warehouse_history_usecase.dart';
import 'warehouse_history_state.dart';

class WarehouseHistoryCubit extends Cubit<WarehouseHistoryState> {
  final GetWarehouseHistoryUseCase getWarehouseHistoryUseCase;
  WarehouseHistoryCubit(this.getWarehouseHistoryUseCase) : super(WarehouseHistoryInitial());

  void getHistory() async {
    emit(WarehouseHistoryLoading());
    final result = await getWarehouseHistoryUseCase.call();
    result.fold(
          (failure) => emit(WarehouseHistoryFailure(failure.message)),
          (history) => emit(WarehouseHistorySuccess(history)),
    );
  }
}