import 'package:get_it/get_it.dart';

// ================== AUTH ==================
import '../../features/analytics/domain/usecases/get_analytics_use_case.dart';
import '../../features/auth/data/repositories/mock_auth_repository.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_use_case.dart';
import '../../features/auth/presentation/manager/auth_cubit.dart';

// ================== HOME ==================
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';

// Sales Chart
import '../../features/home/domain/usecases/get_latest_support_ticket_usecas.dart';
import '../../features/home/domain/usecases/get_sales_chart_usecase.dart';
import '../../features/home/presentation/manager/sales_chart_cubit.dart';

// Low Stock
import '../../features/home/domain/usecases/get_low_stock_usecase.dart';
import '../../features/home/presentation/manager/low_stock_cubit.dart';

// Support Ticket
import '../../features/home/presentation/manager/latest_support_ticket_cubit.dart';

// ================== PRODUCTS ==================
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/repositories/product_repository.dart';
import '../../features/products/domain/usecases/get_product_details_usecase.dart';
import '../../features/products/domain/usecases/get_products_usecase.dart';
import '../../features/products/domain/usecases/copy_product_usecase.dart';
import '../../features/products/domain/usecases/get_warehouse_history_usecase.dart';
import '../../features/products/presentation/manager/product_details_cubit.dart';
import '../../features/products/presentation/manager/products_cubit.dart';
import '../../features/products/presentation/manager/copy_product_cubit.dart';
import '../../features/products/presentation/manager/warehouse_history_cubit.dart';

// ================== ORDERS ==================
import '../../features/orders/Presentation/manager/orders_cubit.dart';
import '../../features/orders/data/repositories/order_repository_impl.dart';
import '../../features/orders/domain/repositories/order_repository.dart';
import '../../features/orders/domain/usecases/get_orders_usecase.dart';

// ================== ANALYTICS ==================
import '../../features/analytics/data/repositories/analytics_repository_impl.dart';
import '../../features/analytics/domain/repositories/analytics_repository.dart';
import '../../features/analytics/presentation/manager/analytics_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {

  // ================== AUTH ==================

  getIt.registerLazySingleton<AuthRepository>(
        () => MockAuthRepository(),
  );

  getIt.registerLazySingleton(
        () => LoginUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory(
        () => AuthCubit(getIt<LoginUseCase>()),
  );

  // ================== HOME ==================

  getIt.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(),
  );

  // ---------- Sales Chart ----------
  getIt.registerLazySingleton(
        () => GetSalesChartUseCase(getIt<HomeRepository>()),
  );

  getIt.registerFactory(
        () => SalesChartCubit(getIt<GetSalesChartUseCase>()),
  );

  // ---------- Low Stock ----------
  getIt.registerLazySingleton(
        () => GetLowStockUseCase(getIt<HomeRepository>()),
  );

  getIt.registerFactory(
        () => LowStockCubit(getIt<GetLowStockUseCase>()),
  );

  // ---------- Support Ticket ----------
  getIt.registerLazySingleton(
        () => GetLatestSupportTicketUseCase(getIt<HomeRepository>()),
  );

  getIt.registerFactory(
        () => LatestSupportTicketCubit(
      getIt<GetLatestSupportTicketUseCase>(),
    ),
  );

  // ================== PRODUCTS ==================

  getIt.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(),
  );

  getIt.registerLazySingleton(
        () => GetProductsUseCase(getIt<ProductRepository>()),
  );

  getIt.registerFactory(
        () => ProductsCubit(getIt<GetProductsUseCase>()),
  );

  // Products Details
  getIt.registerFactory(() => ProductDetailsCubit(getIt()));
  getIt.registerLazySingleton(() => GetProductDetailsUseCase(getIt()));

  // ---------- Copy Product  ----------
  getIt.registerLazySingleton(() => CopyProductUseCase(getIt<ProductRepository>()));
  getIt.registerFactory(() => CopyProductCubit(getIt<CopyProductUseCase>()));

  // ---------- Warehouse History ----------
  getIt.registerLazySingleton(() => GetWarehouseHistoryUseCase(getIt<ProductRepository>()));
  getIt.registerFactory(() => WarehouseHistoryCubit(getIt<GetWarehouseHistoryUseCase>()));


  // ================== ORDERS ==================
  getIt.registerLazySingleton<OrderRepository>(
        () => OrderRepositoryImpl(),
  );

  getIt.registerLazySingleton(
        () => GetOrdersUseCase(getIt<OrderRepository>()),
  );

  getIt.registerFactory(
        () => OrdersCubit(getIt<GetOrdersUseCase>()),
  );

  // ================== ANALYTICS ==================

  getIt.registerLazySingleton<AnalyticsRepository>(
        () => AnalyticsRepositoryImpl(),
  );

  getIt.registerLazySingleton(
        () => GetAnalyticsUseCase(getIt<AnalyticsRepository>()),
  );

  getIt.registerFactory(
        () => AnalyticsCubit(getIt<GetAnalyticsUseCase>()),
  );
}