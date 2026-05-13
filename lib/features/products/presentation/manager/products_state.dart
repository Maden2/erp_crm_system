import '../../domain/entities/product_entity.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}
class ProductsLoading extends ProductsState {}
class ProductsSuccess extends ProductsState {
  final List<ProductEntity> products;
  ProductsSuccess(this.products);
}
class ProductsFailure extends ProductsState {
  final String message;
  ProductsFailure(this.message);
}
class ProductsEmpty extends ProductsState {}

class WarehouseChanged extends ProductsState {
  final String warehouseName;
  WarehouseChanged(this.warehouseName);
}