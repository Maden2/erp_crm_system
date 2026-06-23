import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_router.dart';
import 'app_routes.dart';
import 'app_theme.dart';

class CRMApp extends StatelessWidget {
  const CRMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CRM App',
          theme: AppTheme.lightTheme,
          initialRoute: Routes.invoicesPage,
          onGenerateRoute: AppRouter.onGenerateRoute,
          builder: (context, widget) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: widget!,
            );
          },
        );
      },
    );
  }
}
