// lib/features/products/presentation/manager/website_copy_product_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/website_product_repository.dart';
import 'website_copy_product_state.dart';

class WebsiteCopyProductCubit extends Cubit<WebsiteCopyProductState> {
  final WebsiteProductRepository repository;

  WebsiteCopyProductCubit({required this.repository}) : super(WebsiteCopyProductInitial());

  // 1. جلب المنتجات من المستودع غير المنشورة بالمتجر الإلكتروني
  Future<void> fetchUnpublishedProducts({String? categoryId}) async {
    emit(WebsiteCopyProductLoading());
    final result = await repository.getUnpublishedProducts(categoryId: categoryId);

    result.fold(
          (failure) => emit(WebsiteCopyProductError(failure.message)),
          (products) => emit(WebsiteUnpublishedProductsSuccess(products)),
    );
  }

  // 2. تنفيذ عملية نسخ ونشر المنتج لفئة معينة بالمتجر
  Future<void> publishProduct({
    required String inventoryProductId,
    required double price,
    required bool isPublished,
    required String websiteCategoryId,
    required String nameSnapshot,
  }) async {
    emit(WebsiteCopyProductLoading());
    final result = await repository.publishFromInventory(
      inventoryProductId: inventoryProductId,
      price: price,
      isPublished: isPublished,
      websiteCategoryId: websiteCategoryId,
      nameSnapshot: nameSnapshot,
    );

    result.fold(
          (failure) => emit(WebsiteCopyProductError(failure.message)),
          (_) => emit(WebsiteCopyProductSuccess()),
    );
  }
}