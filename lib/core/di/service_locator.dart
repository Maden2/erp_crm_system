import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ================== SPLASH ==================
import '../../features/customers/domain/repositories/client_repository.dart';
import '../../features/splash/domain/usecases/check_auth_usecase.dart';
import '../../features/splash/presentation/manager/splash_cubit.dart';

// ================== AUTH ==================
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_use_case.dart';
import '../../features/auth/domain/usecases/get_current_user_use_case.dart';
import '../../features/auth/presentation/manager/auth_cubit.dart';
import '../../features/auth/domain/usecases/logout_use_case.dart';

// ================== HOME ==================
import '../../features/home/data/datasources/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_dashboard_home_use_case.dart';
import '../../features/home/domain/usecases/get_dashboard_chart_use_case.dart';
import '../../features/home/presentation/manager/dashboard_home_cubit.dart';
import '../../features/home/presentation/manager/dashboard_chart_cubit.dart';
import '../../features/home/domain/usecases/get_latest_support_ticket_usecas.dart';
import '../../features/home/domain/usecases/get_sales_chart_usecase.dart';
import '../../features/home/presentation/manager/sales_chart_cubit.dart';
import '../../features/home/domain/usecases/get_low_stock_usecase.dart';
import '../../features/home/presentation/manager/low_stock_cubit.dart';
import '../../features/home/presentation/manager/latest_support_ticket_cubit.dart';

// ================== PRODUCTS (OLD INVENTORY) ==================
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

//  ================== WEBSITE PRODUCTS (SERVER REAL LINK) ==================
import '../../features/products/data/datasources/website_product_remote_data_source.dart';
import '../../features/products/data/repositories/website_product_repository_impl.dart';
import '../../features/products/domain/repositories/website_product_repository.dart';
import '../../features/products/domain/usecases/website_product_usecases.dart';
import '../../features/products/presentation/manager/website_products_cubit.dart';
import '../../features/products/presentation/manager/website_product_details_cubit.dart';
import '../../features/products/presentation/manager/website_copy_product_cubit.dart';
import '../../features/products/presentation/manager/website_warehouse_cubit.dart';

// ================== ORDERS (MOCK) ==================
import '../../features/orders/presentation/manager/orders_cubit.dart';
import '../../features/orders/data/repositories/order_repository_impl.dart';
import '../../features/orders/domain/repositories/order_repository.dart';
import '../../features/orders/domain/usecases/get_orders_usecase.dart';

// ================== LIVE ORDERS (SERVER REAL) ==================
import '../../features/orders/data/datasources/live_orders_remote_data_source.dart';
import '../../features/orders/data/repositories/live_orders_repository_impl.dart';
import '../../features/orders/domain/repositories/live_orders_repository.dart';
import '../../features/orders/domain/usecases/get_live_orders_usecase.dart';
import '../../features/orders/domain/usecases/update_live_order_status_usecase.dart';
import '../../features/orders/presentation/manager/live_orders_cubit.dart';

//  ================== FULL ANALYTICS (NEW REQUEST OPTIMIZED) ==================
import '../../features/analytics/data/datasources/full_analytics_remote_data_source.dart';
import '../../features/analytics/data/repositories/full_analytics_repository_impl.dart';
import '../../features/analytics/domain/repositories/full_analytics_repository.dart';
import '../../features/analytics/domain/usecases/get_full_analytics_usecase.dart';
import '../../features/analytics/presentation/manager/full_analytics_cubit.dart';

// ================== ANALYTICS (OLD BACKUP) ==================
import '../../features/analytics/data/repositories/analytics_repository_impl.dart';
import '../../features/analytics/domain/repositories/analytics_repository.dart';
import '../../features/analytics/presentation/manager/analytics_cubit.dart';
import '../../features/analytics/domain/usecases/get_analytics_use_case.dart';

// ================== INVOICES (OLD / MOCK COEXISTING) ==================
import '../../features/invoices/data/datasources/invoice_remote_data_source.dart';
import '../../features/invoices/data/repositories/invoice_repository_impl.dart';
import '../../features/invoices/domain/repositories/invoice_repository.dart';
import '../../features/invoices/domain/usecases/get_invoices_use_case.dart';
import '../../features/invoices/presentation/manager/invoices_cubit.dart';

//  ================== NEW FULL INVOICES FEATURE (SERVER REAL) ==================
import '../../features/invoices/data/datasources/full_invoice_remote_data_source.dart';
import '../../features/invoices/data/repositories/full_invoice_repository_impl.dart';
import '../../features/invoices/domain/repositories/full_invoice_repository.dart';
import '../../features/invoices/domain/usecases/get_full_invoice_details_usecase.dart';
import '../../features/invoices/domain/usecases/get_full_invoice_stats_usecase.dart';
import '../../features/invoices/domain/usecases/get_full_invoice_statuses_usecase.dart';
import '../../features/invoices/domain/usecases/get_full_invoices_usecase.dart';
import '../../features/invoices/presentation/manager/full_invoices_cubit.dart';

// ================== PROFITS ==================
import '../../features/profits/presentation/manager/profits_cubit.dart';

// ================== CUSTOMERS (OLD / MOCK COEXISTING) ==================
import '../../features/customers/presentation/manager/customer_cubit.dart';

// ================== NEW CLIENTS REAL API (COEXISTING IN SAME FOLDER) ==================
import '../../features/customers/data/datasources/client_remote_data_source.dart';
import '../../features/customers/data/repositories/client_repository_impl.dart';
import '../../features/customers/domain/usecases/get_client_details_usecase.dart';
import '../../features/customers/domain/usecases/get_client_stats_usecase.dart';
import '../../features/customers/domain/usecases/get_clients_list_usecase.dart';
import '../../features/customers/presentation/manager/client_cubit.dart';

// ================== COMPLAINTS (NEW MODULE) ==================
import '../../features/complaints/presentation/manager/complaints_cubit.dart';

// ================== NOTIFICATIONS (NEW MODULE) ==================
import '../../features/notifications/presentation/manager/notifications_cubit.dart';

import '../api/api_constants.dart';
import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';
import '../api/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {

  // ================== TOOLS ==================
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPrefs);

  // ================== NETWORK ==================
  getIt.registerLazySingleton<Dio>(() => DioFactory.create());

  getIt.registerLazySingleton<ApiConsumer>(
        () => DioConsumer(getIt<Dio>()),
  );

  // ================== SPLASH FEATURE ==================
  getIt.registerLazySingleton(() => CheckAuthUseCase(getIt<SharedPreferences>()));
  getIt.registerFactory(() => SplashCubit(getIt<CheckAuthUseCase>()));

  // ================== AUTH ==================
  getIt.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => GetCurrentUserUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt<AuthRepository>()));

  getIt.registerFactory(
        () => AuthCubit(
      getIt<LoginUseCase>(),
      getIt<GetCurrentUserUseCase>(),
      getIt<LogoutUseCase>(),
    ),
  );

  // ================== HOME ==================
  getIt.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(remoteDataSource: getIt<HomeRemoteDataSource>()),
  );

  getIt.registerLazySingleton(() => GetDashboardHomeUseCase(getIt<HomeRepository>()));
  getIt.registerLazySingleton(() => GetDashboardChartUseCase(getIt<HomeRepository>()));

  getIt.registerFactory(() => DashboardHomeCubit(getIt<GetDashboardHomeUseCase>()));
  getIt.registerFactory(() => DashboardChartCubit(getIt<GetDashboardChartUseCase>()));

  getIt.registerLazySingleton(() => GetSalesChartUseCase(getIt<HomeRepository>()));
  getIt.registerFactory(() => SalesChartCubit(getIt<GetSalesChartUseCase>()));

  getIt.registerLazySingleton(() => GetLowStockUseCase(getIt<HomeRepository>()));
  getIt.registerFactory(() => LowStockCubit(getIt<GetLowStockUseCase>()));

  getIt.registerLazySingleton(() => GetLatestSupportTicketUseCase(getIt<HomeRepository>()));
  getIt.registerFactory(() => LatestSupportTicketCubit(getIt<GetLatestSupportTicketUseCase>()));

  // ================== PRODUCTS (OLD INVENTORY) ==================
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
  getIt.registerLazySingleton(() => GetProductsUseCase(getIt<ProductRepository>()));
  getIt.registerFactory(() => ProductsCubit(getIt<GetProductsUseCase>()));

  getIt.registerFactory(() => ProductDetailsCubit(getIt()));
  getIt.registerLazySingleton(() => GetProductDetailsUseCase(getIt()));

  getIt.registerLazySingleton(() => CopyProductUseCase(getIt<ProductRepository>()));
  getIt.registerFactory(() => CopyProductCubit(getIt<CopyProductUseCase>()));

  getIt.registerLazySingleton(() => GetWarehouseHistoryUseCase(getIt<ProductRepository>()));
  getIt.registerFactory(() => WarehouseHistoryCubit(getIt<GetWarehouseHistoryUseCase>()));


  //  ================== WEBSITE PRODUCTS (SERVER REAL LINK) ==================
  // 1. Data Source
  getIt.registerLazySingleton<WebsiteProductRemoteDataSource>(
        () => WebsiteProductRemoteDataSourceImpl(getIt<ApiConsumer>()),
  );

  // 2. Repository
  getIt.registerLazySingleton<WebsiteProductRepository>(
        () => WebsiteProductRepositoryImpl(getIt<WebsiteProductRemoteDataSource>()),
  );

  // 3. Use Cases
  getIt.registerLazySingleton(() => GetWebsiteProductsUseCase(getIt<WebsiteProductRepository>()));
  getIt.registerLazySingleton(() => GetWebsiteCategoriesUseCase(getIt<WebsiteProductRepository>()));
  getIt.registerLazySingleton(() => GetWebsiteProductDetailsUseCase(getIt<WebsiteProductRepository>()));
  getIt.registerLazySingleton(() => TogglePublishStateUseCase(getIt<WebsiteProductRepository>()));
  getIt.registerLazySingleton(() => DeleteWebsiteProductUseCase(getIt<WebsiteProductRepository>()));

  // 4. Cubits
  getIt.registerFactory(() => WebsiteProductsCubit(
    getWebsiteProductsUseCase: getIt<GetWebsiteProductsUseCase>(),
    togglePublishStateUseCase: getIt<TogglePublishStateUseCase>(),
  ));

  getIt.registerFactory(() => WebsiteProductDetailsCubit(
    getWebsiteProductDetailsUseCase: getIt<GetWebsiteProductDetailsUseCase>(),
    deleteWebsiteProductUseCase: getIt<DeleteWebsiteProductUseCase>(),
  ));

  getIt.registerFactory(() => WebsiteCopyProductCubit(
    repository: getIt<WebsiteProductRepository>(),
  ));

  getIt.registerFactory(() => WebsiteWarehouseCubit(
    repository: getIt<WebsiteProductRepository>(),
  ));


  // ================== ORDERS (MOCK OLD) ==================
  getIt.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl());
  getIt.registerLazySingleton(() => GetOrdersUseCase(getIt<OrderRepository>()));
  getIt.registerFactory(() => OrdersCubit(getIt<GetOrdersUseCase>()));

  //  ================== LIVE ORDERS (NEW REAL LINK) ==================
  getIt.registerLazySingleton<LiveOrdersRemoteDataSource>(
        () => LiveOrdersRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<LiveOrdersRepository>(
        () => LiveOrdersRepositoryImpl(remoteDataSource: getIt<LiveOrdersRemoteDataSource>()),
  );

  getIt.registerLazySingleton(() => GetLiveOrdersUseCase(getIt<LiveOrdersRepository>()));
  getIt.registerLazySingleton(() => UpdateLiveOrderStatusUseCase(getIt<LiveOrdersRepository>()));

  getIt.registerFactory(() => LiveOrdersCubit(
    getLiveOrdersUseCase: getIt<GetLiveOrdersUseCase>(),
    updateLiveOrderStatusUseCase: getIt<UpdateLiveOrderStatusUseCase>(),
  ));

  //  ================== NEW FULL ANALYTICS FEATURE ==================
  getIt.registerLazySingleton<FullAnalyticsRemoteDataSource>(
        () => FullAnalyticsRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<FullAnalyticsRepository>(
        () => FullAnalyticsRepositoryImpl(remoteDataSource: getIt<FullAnalyticsRemoteDataSource>()),
  );
  getIt.registerLazySingleton(() => GetFullAnalyticsUseCase(getIt<FullAnalyticsRepository>()));
  getIt.registerFactory(() => FullAnalyticsCubit(getFullAnalyticsUseCase: getIt<GetFullAnalyticsUseCase>()));

  // ================== ANALYTICS (OLD BACKUP) ==================
  getIt.registerLazySingleton<AnalyticsRepository>(() => AnalyticsRepositoryImpl());
  getIt.registerLazySingleton(() => GetAnalyticsUseCase(getIt<AnalyticsRepository>()));
  getIt.registerFactory(() => AnalyticsCubit(getIt<GetAnalyticsUseCase>()));

  // ================== INVOICES (OLD / MOCK) ==================
  getIt.registerLazySingleton<InvoiceRemoteDataSource>(() => InvoiceRemoteDataSourceImpl());
  getIt.registerLazySingleton<InvoiceRepository>(
        () => InvoiceRepositoryImpl(remoteDataSource: getIt<InvoiceRemoteDataSource>()),
  );
  getIt.registerLazySingleton(() => GetInvoicesUseCase(getIt<InvoiceRepository>()));
  getIt.registerFactory(() => InvoicesCubit(getInvoicesUseCase: getIt<GetInvoicesUseCase>()));

  //  ================== NEW FULL INVOICES FEATURE (SERVER REAL LINK) ==================
  getIt.registerLazySingleton<FullInvoiceRemoteDataSource>(
        () => FullInvoiceRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<FullInvoiceRepository>(
        () => FullInvoiceRepositoryImpl(remoteDataSource: getIt<FullInvoiceRemoteDataSource>()),
  );
  getIt.registerLazySingleton(() => GetFullInvoicesUseCase(getIt<FullInvoiceRepository>()));
  getIt.registerLazySingleton(() => GetFullInvoiceStatsUseCase(getIt<FullInvoiceRepository>()));
  getIt.registerLazySingleton(() => GetFullInvoiceStatusesUseCase(getIt<FullInvoiceRepository>()));
  getIt.registerLazySingleton(() => GetFullInvoiceDetailsUseCase(getIt<FullInvoiceRepository>()));

  getIt.registerFactory(() => FullInvoicesCubit(
    getFullInvoicesUseCase: getIt<GetFullInvoicesUseCase>(),
    getFullInvoiceStatsUseCase: getIt<GetFullInvoiceStatsUseCase>(),
    getFullInvoiceStatusesUseCase: getIt<GetFullInvoiceStatusesUseCase>(),
    getFullInvoiceDetailsUseCase: getIt<GetFullInvoiceDetailsUseCase>(),
  ));

  //  ================== CUSTOMERS MODULE ==================
  getIt.registerFactory(() => CustomerCubit());

  //  ================== NEW CLIENTS REAL API (COEXISTING IN SAME FOLDER) ==================
  getIt.registerLazySingleton<ClientRemoteDataSource>(
        () => ClientRemoteDataSourceImpl(getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<ClientRepository>(
        () => ClientRepositoryImpl(getIt<ClientRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetClientStatsUseCase(getIt<ClientRepository>()));
  getIt.registerLazySingleton(() => GetClientsListUseCase(getIt<ClientRepository>()));
  getIt.registerLazySingleton(() => GetClientDetailsUseCase(getIt<ClientRepository>()));

  // Cubit
  getIt.registerFactory(() => ClientCubit(
    getClientStatsUseCase: getIt<GetClientStatsUseCase>(),
    getClientsListUseCase: getIt<GetClientsListUseCase>(),
    getClientDetailsUseCase: getIt<GetClientDetailsUseCase>(),
  ));

  //  ================== COMPLAINTS MODULE (MOCK REGISTER) ==================
  getIt.registerFactory(() => ComplaintsCubit());

  //  ================== NOTIFICATIONS MODULE (MOCK REGISTER) ==================
  getIt.registerFactory(() => NotificationsCubit());
}