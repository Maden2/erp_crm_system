import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../di/service_locator.dart'; // 💡 تأكد من مسار الـ service_locator عندك

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    // 1️⃣ بنجيب النسخة المجهزة مسبقاً من الـ SharedPreferences بدون await نهائي!
    final prefs = getIt<SharedPreferences>();
    final token = prefs.getString('token');

    // 2️⃣ الشرط الذكي: بنحط التوكن لو موجود بشرط م نكونش رايحين للـ login
    if (token != null && token.isNotEmpty && !options.path.contains('/auth/login')) {
      options.headers["Authorization"] = "Bearer $token";
    }

    options.headers["Accept"] = "application/json";
    options.headers["Content-Type"] = "application/json";

    // 3️⃣ تمرير الـ Request بسلام ومزامنة 100%
    handler.next(options);
  }
}