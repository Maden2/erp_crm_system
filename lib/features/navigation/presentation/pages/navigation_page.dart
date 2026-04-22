import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                Center(child: Text("الصفحة الرئيسية")),
                Center(child: Text("صفحة المنتجات")),
                Center(child: Text("صفحة الطلبات")),
                Center(child: Text("صفحة التحليلات")),
                Center(child: Text("المزيد")),
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