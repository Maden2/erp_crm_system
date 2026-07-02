import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../analytics/presentation/pages/analytics_page.dart';
import '../../../auth/presentation/manager/auth_cubit.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../more/presentation/pages/more_page.dart';
import '../../../orders/presentation/pages/orders_page.dart';
import '../../../products/presentation/pages/products_page.dart';
import '../manager/navigation_cubit.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NavigationCubit(),
        ),
        BlocProvider(
          create: (_) => getIt<AuthCubit>(),
        ),
      ],
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: IndexedStack(
              index: currentIndex,
              children: const [
                HomePage(),
                ProductsPage(),
                OrdersPage(),
                AnalyticsPage(),
                MorePage(),
              ],
            ),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<NavigationCubit>().changeIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}