import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_product_details_usecase.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailsCubit(this.getProductDetailsUseCase) : super(ProductDetailsInitial());

  void getProductDetails(String productId) async {
    emit(ProductDetailsLoading());

    final result = await getProductDetailsUseCase.call(productId);

    result.fold(
          (failure) => emit(ProductDetailsFailure(failure.message)),
          (product) => emit(ProductDetailsSuccess(product)),
    );
  }
}