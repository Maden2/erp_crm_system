// lib/features/products/presentation/manager/website_warehouse_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/website_product_repository.dart';
import 'website_warehouse_state.dart';

class WebsiteWarehouseCubit extends Cubit<WebsiteWarehouseState> {
  final WebsiteProductRepository repository;

  WebsiteWarehouseCubit({required this.repository}) : super(WebsiteWarehouseInitial());

  // 1. جلب تصنيفات المستودع المتاحة لعمل الـ Mapping مع المتجر الإلكتروني
  Future<void> fetchInventoryCategories({bool tree = false}) async {
    emit(WebsiteWarehouseLoading());
    final result = await repository.getInventoryCategories(tree: tree);

    result.fold(
          (failure) => emit(WebsiteWarehouseError(failure.message)),
          (categories) => emit(WebsiteInventoryCategoriesSuccess(categories)),
    );
  }
}