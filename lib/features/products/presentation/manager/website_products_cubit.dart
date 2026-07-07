// lib/features/products/presentation/manager/website_products_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/website_product_usecases.dart';
import 'website_products_state.dart';

class WebsiteProductsCubit extends Cubit<WebsiteProductsState> {
  final GetWebsiteProductsUseCase getWebsiteProductsUseCase;
  final TogglePublishStateUseCase togglePublishStateUseCase;

  WebsiteProductsCubit({
    required this.getWebsiteProductsUseCase,
    required this.togglePublishStateUseCase,
  }) : super(WebsiteProductsInitial());

  // جلب المنتجات من السيرفر مع الفلاتر والـ Pagination
  Future<void> fetchWebsiteProducts({
    String? search,
    String? categoryId,
    bool? isPublished,
    String? stockStatus,
    int page = 1,
    int limit = 20,
  }) async {
    emit(WebsiteProductsLoading());
    final result = await getWebsiteProductsUseCase(
      search: search,
      categoryId: categoryId,
      isPublished: isPublished,
      stockStatus: stockStatus,
      page: page,
      limit: limit,
    );

    result.fold(
          (failure) => emit(WebsiteProductsError(failure.message)),
          (productList) => emit(WebsiteProductsSuccess(productList)),
    );
  }

  // تبديل حالة النشر طلقة واحدة من الكارت بره بدون تحميل الشاشة كاملة
  Future<void> toggleProductPublish(String id) async {
    final result = await togglePublishStateUseCase(id: id);
    result.fold(
          (failure) => emit(WebsiteProductsError(failure.message)),
          (isPublished) => emit(WebsiteProductTogglePublishSuccess(productId: id, isPublished: isPublished)),
    );
  }
}