// lib/features/products/presentation/manager/website_products_state.dart

import '../../domain/entities/website_product_entities.dart';

abstract class WebsiteProductsState {}

class WebsiteProductsInitial extends WebsiteProductsState {}

class WebsiteProductsLoading extends WebsiteProductsState {}

// حالة النجاح وبترجع لستة المنتجات الحقيقية
class WebsiteProductsSuccess extends WebsiteProductsState {
  final WebsiteProductListEntity productList;
  WebsiteProductsSuccess(this.productList);
}

// حالة الفشل وبترجع رسالة الإيرور النظيفة
class WebsiteProductsError extends WebsiteProductsState {
  final String message;
  WebsiteProductsError(this.message);
}

// حالة نجاح تبديل النشر (Toggle Publish) طلقة واحدة
class WebsiteProductTogglePublishSuccess extends WebsiteProductsState {
  final String productId;
  final bool isPublished;
  WebsiteProductTogglePublishSuccess({required this.productId, required this.isPublished});
}