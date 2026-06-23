import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/low_stock_entity.dart';
import '../../domain/usecases/get_low_stock_usecase.dart';

part 'low_stock_state.dart';

class LowStockCubit extends Cubit<LowStockState> {
  final GetLowStockUseCase useCase;

  LowStockCubit(this.useCase) : super(LowStockInitial());

  Future<void> getLowStock() async {
    emit(LowStockLoading());

    final result = await useCase();

    result.fold(
      (failure) => emit(LowStockError(failure.message)),
      (data) => emit(LowStockSuccess(data)),
    );
  }
}
