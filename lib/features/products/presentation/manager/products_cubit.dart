import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/warehouse_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/product_filter_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUseCase getProductsUseCase;

  ProductsCubit(this.getProductsUseCase) : super(ProductsInitial());

  String selectedWarehouseName = "المخزن الرئيسي";
  String? selectedWarehouseId;
  String selectedCategory = "جميع الفئات";
  String? searchQuery;
  List<ProductEntity> allProducts = [];
  ProductFilterEntity currentFilter = ProductFilterEntity();

  // ================= LOW STOCK =================
  List<ProductEntity> get lowStockItems =>
      allProducts.where((p) => p.quantity > 0 && p.quantity <= 5).toList();

  // ================= SEARCH =================
  void searchProducts(String query) {
    searchQuery = query;
    getProducts(warehouseId: selectedWarehouseId);
  }

  // ================= APPLY FILTER =================
  void applyFilter(ProductFilterEntity newFilter) {
    currentFilter = newFilter;
    getProducts(warehouseId: selectedWarehouseId);
  }

  // ================= CLEAR FILTER =================
  void clearFilter() {
    currentFilter = ProductFilterEntity();
    searchQuery = null;
    getProducts(warehouseId: selectedWarehouseId);
  }

  // ================= CATEGORY =================
  void filterByCategory(String categoryName) {
    selectedCategory = categoryName;
    _emitCurrentState();
  }

  // ================= GET PRODUCTS =================
  void getProducts({String? warehouseId}) async {
    emit(ProductsLoading());

    final result = await getProductsUseCase.call(
      warehouseId: warehouseId ?? selectedWarehouseId,
      filter: currentFilter,
      query: searchQuery,
    );

    result.fold((failure) => emit(ProductsFailure(failure.message)), (
      products,
    ) {
      allProducts = products;
      _emitCurrentState();
    });
  }

  // ================= EMIT STATE =================
  void _emitCurrentState() {
    List<ProductEntity> filteredList = List.from(allProducts);

    // ================= CATEGORY FILTER =================
    if (selectedCategory != "جميع الفئات") {
      filteredList = filteredList
          .where((p) => p.category == selectedCategory)
          .toList();
    }

    // ================= STOCK FILTER =================
    if (currentFilter.stockStatus != null &&
        currentFilter.stockStatus!.isNotEmpty) {
      if (currentFilter.stockStatus == "منخفض") {
        filteredList = filteredList
            .where((p) => p.isLowStock && p.quantity > 0)
            .toList();
      } else if (currentFilter.stockStatus == "نفاد") {
        filteredList = filteredList.where((p) => p.quantity == 0).toList();
      } else if (currentFilter.stockStatus == "مستقر") {
        filteredList = filteredList
            .where((p) => !p.isLowStock && p.quantity > 0)
            .toList();
      }
    }

    // ================= CATEGORY FILTER FROM SHEET =================
    if (currentFilter.category != null && currentFilter.category!.isNotEmpty) {
      filteredList = filteredList
          .where((p) => p.category == currentFilter.category)
          .toList();
    }

    // ================= MIN PRICE =================
    if (currentFilter.minPrice != null) {
      filteredList = filteredList.where((p) {
        final price = double.tryParse(p.price) ?? 0;
        return price >= currentFilter.minPrice!;
      }).toList();
    }

    // ================= MAX PRICE =================
    if (currentFilter.maxPrice != null) {
      filteredList = filteredList.where((p) {
        final price = double.tryParse(p.price) ?? 0;
        return price <= currentFilter.maxPrice!;
      }).toList();
    }

    // ================= EMPTY =================
    if (filteredList.isEmpty) {
      emit(ProductsEmpty());
      return;
    }

    // ================= SUCCESS =================
    emit(ProductsSuccess(filteredList));
  }

  // ================= WAREHOUSE =================
  void filterByWarehouse(WarehouseEntity warehouse) {
    selectedWarehouseId = warehouse.id;
    selectedWarehouseName = warehouse.name;
    emit(WarehouseChanged(selectedWarehouseName));
    getProducts(warehouseId: selectedWarehouseId);
  }
}
