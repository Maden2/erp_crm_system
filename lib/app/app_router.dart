import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/service_locator.dart';

// Auth
import '../features/auth/presentation/manager/auth_cubit.dart';
import '../features/auth/presentation/pages/forgot_password_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/phone_number_page.dart';
import '../features/auth/presentation/pages/reset_password_page.dart';
import '../features/auth/presentation/pages/signup_success_page.dart';
import '../features/auth/presentation/pages/success_page.dart';
import '../features/auth/presentation/pages/signup_page.dart';

// Navigation
import '../features/home/presentation/manager/sales_chart_cubit.dart';
import '../features/navigation/presentation/pages/navigation_page.dart';


import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
    // ================== AUTH ==================

      case Routes.initial:
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const LoginPage(),
          ),
        );

      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordPage(),
        );

      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordPage(),
        );

      case Routes.success:
        return MaterialPageRoute(
          builder: (_) => const SuccessPage(),
        );

      case Routes.signup:
        return MaterialPageRoute(
          builder: (_) => const SignupPage(),
        );

      case Routes.phoneNumber:
        return MaterialPageRoute(
          builder: (_) => const PhoneNumberPage(),
        );

      case Routes.signupSuccess:
        return MaterialPageRoute(
          builder: (_) => const SignupSuccessPage(),
        );

    // ================== MAIN APP ==================

      case Routes.navigationPage:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              /// 🔥 Sales Chart Cubit
              BlocProvider(
                create: (context) => getIt<SalesChartCubit>()
                  ..getSalesChart(filter: "1أ"),
              ),
            ],
            child: const NavigationPage(),
          ),
        );

      case Routes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Dashboard Screen")),
          ),
        );

      case Routes.productDetails:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("Product: $arguments"),
            ),
          ),
        );

    // ================== DEFAULT ==================

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}