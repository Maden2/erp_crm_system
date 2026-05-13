import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/di/service_locator.dart';
import '../features/auth/presentation/manager/auth_cubit.dart';
import '../features/auth/presentation/pages/forgot_password_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/phone_number_page.dart';
import '../features/auth/presentation/pages/reset_password_page.dart';
import '../features/auth/presentation/pages/signup_page.dart';
import '../features/auth/presentation/pages/signup_success_page.dart';
import '../features/auth/presentation/pages/success_page.dart';
import '../features/home/presentation/manager/sales_chart_cubit.dart';
import '../features/navigation/presentation/pages/navigation_page.dart';
import '../features/products/domain/entities/product_details_entity.dart';
import '../features/products/presentation/manager/copy_product_cubit.dart';
import '../features/products/presentation/manager/product_details_cubit.dart';
import '../features/products/presentation/manager/warehouse_history_cubit.dart';
import '../features/products/presentation/pages/add_warehouse_page.dart';
import '../features/products/presentation/pages/copy_product_page.dart';
import '../features/products/presentation/pages/product_details_page.dart';
import '../features/products/presentation/pages/warehouse_history_page.dart';
import '../features/products/presentation/pages/warehouses_management_page.dart';
import 'app_routes.dart';


class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
    // ================== AUTH ==================
      case Routes.initial:
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

    // ================== DEFAULT ==================
      default:
        return _errorRoute(settings);
    }
  }

  // ------------------ 1. Auth Module ------------------
  static Route<dynamic> _authRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initial:
      case Routes.login:
        return MaterialPageRoute(builder: (_) => BlocProvider(create: (_) => getIt<AuthCubit>(), child: const LoginPage()));
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
      default: return _errorRoute(settings);
    }
  }

  // ------------------ 2. Home Module ------------------
  static Route<dynamic> _homeRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.navigationPage:
        return MaterialPageRoute(builder: (_) => MultiBlocProvider(providers: [
          BlocProvider(create: (_) => getIt<SalesChartCubit>()..getSalesChart(filter: "1أ")),
        ], child: const NavigationPage()));
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text("Dashboard"))));
      default: return _errorRoute(settings);
    }
  }

  // ------------------ 3. Product Module ------------------
  static Route<dynamic> _productRoutes(RouteSettings settings, dynamic arguments) {
    switch (settings.name) {
      case Routes.productsPage:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text("Product: $arguments"))));
      case Routes.productDetails:
        final productId = arguments as String;
        return MaterialPageRoute(builder: (_) => BlocProvider(
          create: (_) => getIt<ProductDetailsCubit>()..getProductDetails(productId),
          child: ProductDetailsPage(productId: productId),
        ));
      case Routes.copyProductPage:
        final product = arguments as ProductDetailsEntity;
        return MaterialPageRoute(builder: (_) => BlocProvider(
          create: (_) => getIt<CopyProductCubit>(),
          child: CopyProductPage(product: product),
        ));
      default: return _errorRoute(settings);
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

      default: return _errorRoute(settings);
    }
  }

  // ------------------ Error Page ------------------
  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))));
  }
}