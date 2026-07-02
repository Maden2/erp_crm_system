import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_constants.dart';
import 'interceptors/auth_interceptor.dart';

class DioFactory {
  static Dio create() {
    final Dio dio = Dio();

    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      receiveDataWhenStatusError: true,
      // 💡 شيلنا الهيدرز الثابتة من هنا لأن الـ AuthInterceptor بيضيفها تلقائياً لكل Request
    );

    // Authorization Header & Global Headers
    dio.interceptors.add(AuthInterceptor());

    // Logger
    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 120,
      ),
    );

    return dio;
  }
}