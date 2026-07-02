import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});

  @override
  String toString() => "ServerException(statusCode: $statusCode, message: $message)";
}

class CacheException implements Exception {
  final String message;
  CacheException({required this.message});
}

ServerException handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return ServerException(message: "انتهت مهلة الاتصال بالسيرفر، يرجى المحاولة لاحقاً.");

    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;

      String errorMessage;

      switch (statusCode) {
        case 400:
          errorMessage = "البيانات المدخلة غير صحيحة";
          break;

        case 401:
          errorMessage = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
          break;

        case 403:
          errorMessage = "تم إيقاف الحساب، تواصل مع الإدارة";
          break;

        case 423:
          errorMessage =
          "تم قفل الحساب بسبب كثرة المحاولات الخاطئة";
          break;

        case 429:
          errorMessage =
          "تم تجاوز عدد المحاولات المسموح بها، حاول لاحقاً";
          break;

        case 500:
          errorMessage = "حدث خطأ في السيرفر";
          break;

        default:
          errorMessage =
              responseData?['message'] ?? "حدث خطأ غير متوقع";
      }

      return ServerException(
        message: errorMessage,
        statusCode: statusCode,
      );

    case DioExceptionType.cancel:
      return ServerException(message: "تم إلغاء طلب الاتصال بالسيرفر.");

    case DioExceptionType.connectionError:
      return ServerException(message: "لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.");

    case DioExceptionType.unknown:
    default:
      return ServerException(message: "حدث خطأ غير معروف، يرجى المحاولة مرة أخرى.");
  }
}