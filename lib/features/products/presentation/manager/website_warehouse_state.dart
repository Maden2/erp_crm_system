abstract class WebsiteWarehouseState {}

class WebsiteWarehouseInitial extends WebsiteWarehouseState {}
class WebsiteWarehouseLoading extends WebsiteWarehouseState {}

class WebsiteInventoryCategoriesSuccess extends WebsiteWarehouseState {
  final List<dynamic> categories;
  WebsiteInventoryCategoriesSuccess(this.categories);
}

// 🟢 حالات النجاح الجديدة
class WebsiteWarehousesSuccess extends WebsiteWarehouseState {
  final List<dynamic> warehouses;
  WebsiteWarehousesSuccess(this.warehouses);
}

class WebsiteStockMovesSuccess extends WebsiteWarehouseState {
  final List<dynamic> stockMoves;
  WebsiteStockMovesSuccess(this.stockMoves);
}

class WebsiteWarehouseError extends WebsiteWarehouseState {
  final String message;
  WebsiteWarehouseError(this.message);
}