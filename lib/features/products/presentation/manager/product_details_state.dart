import '../../domain/entities/product_details_entity.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsSuccess extends ProductDetailsState {
  final ProductDetailsEntity product;
  ProductDetailsSuccess(this.product);
}

final class ProductDetailsFailure extends ProductDetailsState {
  final String message;
  ProductDetailsFailure(this.message);
}
