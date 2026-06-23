import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../analytics/presentation/pages/analytics_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../more/presentation/pages/more_page.dart';
import '../../../orders/Presentation/pages/orders_page.dart';
import '../../../products/presentation/pages/products_page.dart';
import '../manager/navigation_cubit.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
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
