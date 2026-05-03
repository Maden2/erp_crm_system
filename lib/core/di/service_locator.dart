import 'package:get_it/get_it.dart';

// ================== AUTH ==================
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

//  Support Ticket
import '../../features/home/presentation/manager/latest_support_ticket_cubit.dart';

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

  // ----------  Support Ticket ----------
  getIt.registerLazySingleton(
        () => GetLatestSupportTicketUseCase(getIt<HomeRepository>()),
  );

  getIt.registerFactory(
        () => LatestSupportTicketCubit(
      getIt<GetLatestSupportTicketUseCase>(),
    ),
  );
}