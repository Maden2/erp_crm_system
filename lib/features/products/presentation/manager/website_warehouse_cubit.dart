import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/website_product_repository.dart';
import 'website_warehouse_state.dart';

class WebsiteWarehouseCubit extends Cubit<WebsiteWarehouseState> {
  final WebsiteProductRepository repository;

  WebsiteWarehouseCubit({required this.repository}) : super(WebsiteWarehouseInitial());

  // 1. جلب تصنيفات المستودع
  Future<void> fetchInventoryCategories({bool tree = false}) async {
    emit(WebsiteWarehouseLoading());
    final result = await repository.getInventoryCategories(tree: tree);
    result.fold(
          (failure) => emit(WebsiteWarehouseError(failure.message)),
          (categories) => emit(WebsiteInventoryCategoriesSuccess(categories)),
    );
  }

  // 2. جلب المخازن (الجديدة)
  Future<void> fetchWarehouses() async {
    emit(WebsiteWarehouseLoading());
    final result = await repository.getWarehouses();
    result.fold(
          (failure) => emit(WebsiteWarehouseError(failure.message)),
          (warehouses) => emit(WebsiteWarehousesSuccess(warehouses)),
    );
  }

  // 3. جلب حركات المخزون (الجديدة)
  Future<void> fetchStockMoves({String? productId, String? warehouseId, String? moveType}) async {
    emit(WebsiteWarehouseLoading());
    final result = await repository.getStockMoves(
      productId: productId,
      warehouseId: warehouseId,
      moveType: moveType,
    );
    result.fold(
          (failure) => emit(WebsiteWarehouseError(failure.message)),
          (moves) => emit(WebsiteStockMovesSuccess(moves)),
    );
  }
}