// lib/features/products/presentation/manager/website_copy_product_state.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/website_product_entities.dart';

abstract class WebsiteCopyProductState extends Equatable {
  const WebsiteCopyProductState();

  @override
  List<Object?> get props => [];
}

class WebsiteCopyProductInitial extends WebsiteCopyProductState {}

class WebsiteCopyProductLoading extends WebsiteCopyProductState {}

// حالة نجاح جلب المنتجات غير المنشورة من المستودع
class WebsiteUnpublishedProductsSuccess extends WebsiteCopyProductState {
  final List<WebsiteUnpublishedProductEntity> products;

  const WebsiteUnpublishedProductsSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

// حالة نجاح عملية نسخ ونشر المنتج للمتجر
class WebsiteCopyProductSuccess extends WebsiteCopyProductState {}

class WebsiteCopyProductError extends WebsiteCopyProductState {
  final String message;

  const WebsiteCopyProductError(this.message);

  @override
  List<Object?> get props => [message];
}