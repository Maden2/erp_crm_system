// lib/features/products/presentation/manager/website_product_details_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/website_product_usecases.dart';
import 'website_product_details_state.dart';

class WebsiteProductDetailsCubit extends Cubit<WebsiteProductDetailsState> {
  final GetWebsiteProductDetailsUseCase getWebsiteProductDetailsUseCase;
  final DeleteWebsiteProductUseCase deleteWebsiteProductUseCase;

  WebsiteProductDetailsCubit({
    required this.getWebsiteProductDetailsUseCase,
    required this.deleteWebsiteProductUseCase,
  }) : super(WebsiteProductDetailsInitial());

  // جلب تفاصيل المنتج بالكامل لشاشة التفاصيل
  Future<void> fetchProductDetails(String id) async {
    emit(WebsiteProductDetailsLoading());
    final result = await getWebsiteProductDetailsUseCase(id: id);

    result.fold(
          (failure) => emit(WebsiteProductDetailsError(failure.message)),
          (detail) => emit(WebsiteProductDetailsSuccess(detail)),
    );
  }

  // حذف المنتج من المتجر الإلكتروني
  Future<void> deleteProduct(String id) async {
    emit(WebsiteProductDetailsLoading());
    final result = await deleteWebsiteProductUseCase(id: id);

    result.fold(
          (failure) => emit(WebsiteProductDetailsError(failure.message)),
          (_) => emit(WebsiteProductDeleteSuccess()),
    );
  }
}