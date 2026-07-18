import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../analytics/presentation/pages/analytics_page.dart';
import '../../../auth/presentation/manager/auth_cubit.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../more/presentation/pages/more_page.dart';
import '../../../orders/presentation/pages/orders_page.dart';
import '../../../products/presentation/pages/products_page.dart';
import '../../../ai_assistant/presentation/manager/ai_assistant_cubit.dart';
import '../../../ai_assistant/presentation/widgets/draggable_ai_button.dart';
import '../../../ai_assistant/presentation/widgets/ai_insights_bottom_sheet_content.dart'; // استيراد محتوى الشيت الجديد
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
        BlocProvider(
          create: (_) => getIt<AiAssistantCubit>(), // 🟢 توفير الـ Cubit المركزي للذكاء الاصطناعي
        ),
      ],
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: Stack(
              children: [
                IndexedStack(
                  index: currentIndex,
                  children: const [
                    HomePage(),
                    ProductsPage(),
                    OrdersPage(),
                    AnalyticsPage(),
                    MorePage(),
                  ],
                ),
                // 🟢 حقن زر الـ AI التفاعلي ليكون عائمًا ويتحرك فوق كافة الشاشات
                DraggableAiButton(
                  onTap: () {
                    context.read<AiAssistantCubit>().fetchAiInsights();
                    _showAiInsightsBottomSheet(context);
                  },
                ),
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

  void _showAiInsightsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // 🟢 جعل الخلفية شفافة ليلقط انحناء الـ Container الداخلي
      builder: (modalContext) => BlocProvider.value(
        value: context.read<AiAssistantCubit>(), // 🟢 تمرير الـ Cubit الحالي لشجرة الـ Bottom Sheet مسطرة
        child: const AiInsightsBottomSheetContent(), // 🟢 استدعاء الـ UI المربوط بالـ BlocBuilder
      ),
    );
  }
}