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

  // 🟢 إضافة warehouseId للبارامترات
  Future<void> fetchWebsiteProducts({
    String? search,
    String? categoryId,
    String? warehouseId, // 🟢 إضافة الـ ID
    bool? isPublished,
    String? stockStatus,
    int page = 1,
    int limit = 20,
  }) async {
    emit(WebsiteProductsLoading());
    final result = await getWebsiteProductsUseCase(
      search: search,
      categoryId: categoryId,
      warehouseId: warehouseId, // 🟢 تمرير الـ ID
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

  Future<void> toggleProductPublish(String id) async {
    final result = await togglePublishStateUseCase(id: id);
    result.fold(
          (failure) => emit(WebsiteProductsError(failure.message)),
          (isPublished) => emit(WebsiteProductTogglePublishSuccess(productId: id, isPublished: isPublished)),
    );
  }
}