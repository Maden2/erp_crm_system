import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/copy_product_usecase.dart';
import 'copy_product_state.dart';

class CopyProductCubit extends Cubit<CopyProductState> {
  final CopyProductUseCase copyProductUseCase;

  CopyProductCubit(this.copyProductUseCase) : super(CopyProductInitial());

  Future<void> copyProduct({
    required String productId,
    required String warehouseId,
  }) async {
    emit(CopyProductLoading());

    final result = await copyProductUseCase.call(
      productId: productId,
      warehouseId: warehouseId,
    );

    result.fold(
      (failure) => emit(CopyProductFailure(failure.message)),
      (_) => emit(CopyProductSuccess()),
    );
  }
}
