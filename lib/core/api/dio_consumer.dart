import 'package:dio/dio.dart';
import 'api_consumer.dart';
import '../error/exceptions.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio);

  @override
  Future get(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      print("========== DIO ==========");
      print("TYPE: ${e.type}");
      print("MESSAGE: ${e.message}");
      print("ERROR: ${e.error}");
      print("RESPONSE: ${e.response?.data}");
      print("STATUS: ${e.response?.statusCode}");
      print("=========================");

      throw handleDioException(e);
    }
  }

  @override
  Future post(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      print("========== LOGIN ERROR ==========");
      print("TYPE: ${e.type}");
      print("MESSAGE: ${e.message}");
      print("ERROR: ${e.error}");
      print("STATUS: ${e.response?.statusCode}");
      print("RESPONSE: ${e.response?.data}");
      print("STACK: ${e.stackTrace}");
      print("================================");

      throw handleDioException(e);
    }
  }

  @override
  Future put(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  @override
  Future delete(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  // 🟢 إضافة ميثود الـ PATCH الاحترافية مع هندسة أخطاء الـ Dio
  @override
  Future patch(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      print("========== DIO PATCH ERROR ==========");
      print("TYPE: ${e.type}");
      print("MESSAGE: ${e.message}");
      print("RESPONSE: ${e.response?.data}");
      print("STATUS: ${e.response?.statusCode}");
      print("=====================================");
      throw handleDioException(e);
    }
  }
}