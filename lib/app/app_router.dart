import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/di/service_locator.dart';

// Splash Import
import '../features/splash/presentation/manager/splash_cubit.dart';
import '../features/splash/presentation/pages/splash_page.dart';

// Auth Imports
import '../features/auth/presentation/manager/auth_cubit.dart';
import '../features/auth/presentation/pages/forgot_password_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/phone_number_page.dart';
import '../features/auth/presentation/pages/reset_password_page.dart';
import '../features/auth/presentation/pages/signup_page.dart';
import '../features/auth/presentation/pages/signup_success_page.dart';
import '../features/auth/presentation/pages/success_page.dart';

// Home & Nav Imports
import '../features/home/presentation/manager/sales_chart_cubit.dart';
import '../features/navigation/presentation/pages/navigation_page.dart';

// Products Imports
import '../features/orders/Presentation/pages/order_details_page.dart';
import '../features/orders/Presentation/pages/orders_page.dart';
import '../features/products/domain/entities/product_details_entity.dart';
import '../features/products/presentation/manager/copy_product_cubit.dart';
import '../features/products/presentation/manager/product_details_cubit.dart';
import '../features/products/presentation/manager/warehouse_history_cubit.dart';
import '../features/products/presentation/pages/add_warehouse_page.dart';
import '../features/products/presentation/pages/copy_product_page.dart';
import '../features/products/presentation/pages/product_details_page.dart';
import '../features/products/presentation/pages/warehouse_history_page.dart';
import '../features/products/presentation/pages/warehouses_management_page.dart';

// 🟢 LIVE ORDERS IMPORTS (تم تحديث الـ Imports لقراءة الملفات الحقيقية لايف)
import '../features/orders/domain/entities/live_order_entity.dart';
import '../features/orders/presentation/manager/live_orders_cubit.dart';

// ================== INVOICES ==================
import '../features/invoices/presentation/manager/invoices_cubit.dart';
import '../features/invoices/presentation/pages/invoices_screen.dart';

// ================== PROFITS ==================
import '../features/profits/presentation/manager/profits_cubit.dart';
import '../features/profits/presentation/pages/profits_screen.dart';

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
    // ================== SPLASH & AUTH ==================
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<SplashCubit>(),
            child: const SplashPage(),
          ),
        );
      case Routes.login:
      case Routes.forgotPassword:
      case Routes.resetPassword:
      case Routes.success:
      case Routes.signup:
      case Routes.phoneNumber:
      case Routes.signupSuccess:
        return _authRoutes(settings);

    // ================== MAIN APP & HOME ==================
      case Routes.navigationPage:
      case Routes.dashboard:
        return _homeRoutes(settings);

    // ================== PRODUCTS ==================
      case Routes.productsPage:
      case Routes.productDetails:
      case Routes.copyProductPage:
        return _productRoutes(settings, arguments);

    // ================== WAREHOUSES ==================
      case Routes.warehousesManagement:
      case Routes.addWarehouse:
      case Routes.warehouseHistory:
        return _warehouseRoutes(settings);

    // ================== ORDERS ==================
      case Routes.ordersPage:
      case Routes.orderDetails:
        return _orderRoutes(settings, arguments);

    // ================== INVOICES ==================
      case Routes.invoicesPage:
        return _invoiceRoutes(settings);

    // ================== PROFITS ==================
      case Routes.profitsPage:
        return _profitsRoutes(settings);

    // ================== DEFAULT ==================
      default:
        return _errorRoute(settings);
    }
  }

  // ------------------ 1. Auth Module ------------------
  static Route<dynamic> _authRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const LoginPage(),
          ),
        );
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordPage());
      case Routes.success:
        return MaterialPageRoute(builder: (_) => const SuccessPage());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case Routes.phoneNumber:
        return MaterialPageRoute(builder: (_) => const PhoneNumberPage());
      case Routes.signupSuccess:
        return MaterialPageRoute(builder: (_) => const SignupSuccessPage());
      default:
        return _errorRoute(settings);
    }
  }

  // ------------------ 2. Home Module ------------------
  static Route<dynamic> _homeRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.navigationPage:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<SalesChartCubit>()..getSalesChart(filter: "1أ"),
              ),
            ],
            child: const NavigationPage(),
          ),
        );
      case Routes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text("Dashboard"))),
        );
      default:
        return _errorRoute(settings);
    }
  }

  // ------------------ 3. Product Module ------------------
  static Route<dynamic> _productRoutes(RouteSettings settings, dynamic arguments) {
    switch (settings.name) {
      case Routes.productsPage:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("Product: $arguments"))),
        );
      case Routes.productDetails:
        final productId = arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ProductDetailsCubit>()..getProductDetails(productId),
            child: ProductDetailsPage(productId: productId),
          ),
        );
      case Routes.copyProductPage:
        final product = arguments as ProductDetailsEntity;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<CopyProductCubit>(),
            child: CopyProductPage(product: product),
          ),
        );
      default:
        return _errorRoute(settings);
    }
  }

  // ------------------ 4. Warehouse Module ------------------
  static Route<dynamic> _warehouseRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.warehousesManagement:
        return MaterialPageRoute(builder: (_) => const WarehousesManagementPage());
      case Routes.addWarehouse:
        return MaterialPageRoute(builder: (_) => const AddWarehousePage());
      case Routes.warehouseHistory:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<WarehouseHistoryCubit>()..getHistory(),
            child: const WarehouseHistoryPage(),
          ),
        );
      default:
        return _errorRoute(settings);
    }
  }

  // ------------------ 5. Order Module ------------------
  static Route<dynamic> _orderRoutes(RouteSettings settings, dynamic arguments) {
    switch (settings.name) {
      case Routes.ordersPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            // 🟢 تم التحديث لقراءة الـ LiveOrdersCubit وجلب الداتا "الكل" كبداية مأمنة
            create: (context) => getIt<LiveOrdersCubit>()..getLiveOrders(statusTab: "الكل"),
            child: const OrdersPage(),
          ),
        );
      case Routes.orderDetails:
      // 🟢 تم التحديث لاستقبال الـ LiveOrderEntity المنقولة من الـ Card بنجاح
        final order = arguments as LiveOrderEntity;
        return MaterialPageRoute(builder: (_) => OrderDetailsPage(order: order));
      default:
        return _errorRoute(settings);
    }
  }

  // ------------------ 6. Invoice Module ------------------
  static Route<dynamic> _invoiceRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.invoicesPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<InvoicesCubit>()..fetchInvoices(),
            child: const InvoicesScreen(),
          ),
        );
      default:
        return _errorRoute(settings);
    }
  }

  // ------------------ 7. Profits Module ------------------
  static Route<dynamic> _profitsRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.profitsPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ProfitsCubit>()..fetchProfitsData(),
            child: const ProfitsScreen(),
          ),
        );
      default:
        return _errorRoute(settings);
    }
  }

  // ------------------ Error Page ------------------
  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for ${settings.name}')),
      ),
    );
  }
}