import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ================== SPLASH ==================
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

// ================== ORDERS (MOCK) ==================
import '../../features/orders/presentation/manager/orders_cubit.dart';
import '../../features/orders/data/repositories/order_repository_impl.dart';
import '../../features/orders/domain/repositories/order_repository.dart';
import '../../features/orders/domain/usecases/get_orders_usecase.dart';

// 🟢 ================== LIVE ORDERS (SERVER REAL) ==================
import '../../features/orders/data/datasources/live_orders_remote_data_source.dart';
import '../../features/orders/data/repositories/live_orders_repository_impl.dart';
import '../../features/orders/domain/repositories/live_orders_repository.dart';
import '../../features/orders/domain/usecases/get_live_orders_usecase.dart';
import '../../features/orders/domain/usecases/update_live_order_status_usecase.dart';
import '../../features/orders/presentation/manager/live_orders_cubit.dart'; // 🟢 مضاف هنا

// ================== ANALYTICS ==================
import '../../features/analytics/data/repositories/analytics_repository_impl.dart';
import '../../features/analytics/domain/repositories/analytics_repository.dart';
import '../../features/analytics/presentation/manager/analytics_cubit.dart';
import '../../features/analytics/domain/usecases/get_analytics_use_case.dart';

// ================== INVOICES ==================
import '../../features/invoices/data/datasources/invoice_remote_data_source.dart';
import '../../features/invoices/data/repositories/invoice_repository_impl.dart';
import '../../features/invoices/domain/repositories/invoice_repository.dart';
import '../../features/invoices/domain/usecases/get_invoices_use_case.dart';
import '../../features/invoices/presentation/manager/invoices_cubit.dart';

// ================== PROFITS ==================
import '../../features/profits/presentation/manager/profits_cubit.dart';
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

  // ================== PRODUCTS ==================
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
  getIt.registerLazySingleton(() => GetProductsUseCase(getIt<ProductRepository>()));
  getIt.registerFactory(() => ProductsCubit(getIt<GetProductsUseCase>()));

  getIt.registerFactory(() => ProductDetailsCubit(getIt()));
  getIt.registerLazySingleton(() => GetProductDetailsUseCase(getIt()));

  getIt.registerLazySingleton(() => CopyProductUseCase(getIt<ProductRepository>()));
  getIt.registerFactory(() => CopyProductCubit(getIt<CopyProductUseCase>()));

  getIt.registerLazySingleton(() => GetWarehouseHistoryUseCase(getIt<ProductRepository>()));
  getIt.registerFactory(() => WarehouseHistoryCubit(getIt<GetWarehouseHistoryUseCase>()));

  // ================== ORDERS (MOCK OLD) ==================
  getIt.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl());
  getIt.registerLazySingleton(() => GetOrdersUseCase(getIt<OrderRepository>()));
  getIt.registerFactory(() => OrdersCubit(getIt<GetOrdersUseCase>()));

  // 🟢 ================== LIVE ORDERS (NEW REAL LINK) ==================
  getIt.registerLazySingleton<LiveOrdersRemoteDataSource>(
        () => LiveOrdersRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<LiveOrdersRepository>(
        () => LiveOrdersRepositoryImpl(remoteDataSource: getIt<LiveOrdersRemoteDataSource>()),
  );

  getIt.registerLazySingleton(() => GetLiveOrdersUseCase(getIt<LiveOrdersRepository>()));
  getIt.registerLazySingleton(() => UpdateLiveOrderStatusUseCase(getIt<LiveOrdersRepository>()));

  // 4️⃣ تسجيل الـ LiveOrdersCubit الجديد بنجاح هنا
  getIt.registerFactory(() => LiveOrdersCubit(
    getLiveOrdersUseCase: getIt<GetLiveOrdersUseCase>(),
    updateLiveOrderStatusUseCase: getIt<UpdateLiveOrderStatusUseCase>(),
  ));

  // ================== ANALYTICS ==================
  getIt.registerLazySingleton<AnalyticsRepository>(() => AnalyticsRepositoryImpl());
  getIt.registerLazySingleton(() => GetAnalyticsUseCase(getIt<AnalyticsRepository>()));
  getIt.registerFactory(() => AnalyticsCubit(getIt<GetAnalyticsUseCase>()));

  // ================== INVOICES ==================
  getIt.registerLazySingleton<InvoiceRemoteDataSource>(() => InvoiceRemoteDataSourceImpl());
  getIt.registerLazySingleton<InvoiceRepository>(
        () => InvoiceRepositoryImpl(remoteDataSource: getIt<InvoiceRemoteDataSource>()),
  );
  getIt.registerLazySingleton(() => GetInvoicesUseCase(getIt<InvoiceRepository>()));
  getIt.registerFactory(() => InvoicesCubit(getInvoicesUseCase: getIt<GetInvoicesUseCase>()));
}