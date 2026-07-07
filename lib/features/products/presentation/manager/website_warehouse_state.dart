// lib/features/products/presentation/manager/website_warehouse_state.dart

import 'package:equatable/equatable.dart';

abstract class WebsiteWarehouseState extends Equatable {
  const WebsiteWarehouseState();

  @override
  List<Object?> get props => [];
}

class WebsiteWarehouseInitial extends WebsiteWarehouseState {}

class WebsiteWarehouseLoading extends WebsiteWarehouseState {}

// حالة نجاح جلب تصنيفات المخازن المتاحة للـ Mapping
class WebsiteInventoryCategoriesSuccess extends WebsiteWarehouseState {
  final List<dynamic> categories;

  const WebsiteInventoryCategoriesSuccess(this.categories);

  @override
  List<Object?> get props => [categories];
}

class WebsiteWarehouseError extends WebsiteWarehouseState {
  final String message;

  const WebsiteWarehouseError(this.message);

  @override
  List<Object?> get props => [message];
}