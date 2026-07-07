// lib/features/products/presentation/manager/website_product_details_state.dart

import '../../domain/entities/website_product_entities.dart';

abstract class WebsiteProductDetailsState {}

class WebsiteProductDetailsInitial extends WebsiteProductDetailsState {}

class WebsiteProductDetailsLoading extends WebsiteProductDetailsState {}

class WebsiteProductDetailsSuccess extends WebsiteProductDetailsState {
  final WebsiteProductDetailEntity productDetail;
  WebsiteProductDetailsSuccess(this.productDetail);
}

class WebsiteProductDetailsError extends WebsiteProductDetailsState {
  final String message;
  WebsiteProductDetailsError(this.message);
}

class WebsiteProductDeleteSuccess extends WebsiteProductDetailsState {}