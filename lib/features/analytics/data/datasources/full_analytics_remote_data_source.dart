import '../../../../core/api/api_constants.dart';
import '../../../../core/api/api_consumer.dart';
import '../models/full_analytics_model.dart';

abstract class FullAnalyticsRemoteDataSource {
  Future<FullAnalyticsModel> getFullAnalytics({
    required String period,
    String? dateFrom,
    String? dateTo,
  });
}

class FullAnalyticsRemoteDataSourceImpl implements FullAnalyticsRemoteDataSource {
  final ApiConsumer apiConsumer;

  FullAnalyticsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<FullAnalyticsModel> getFullAnalytics({
    required String period,
    String? dateFrom,
    String? dateTo,
  }) async {
    // بناء الـ Query Parameters ديناميكياً حسب المتاح في الـ API
    final Map<String, dynamic> queryParameters = {
      'period': period,
    };
    if (dateFrom != null && dateFrom.isNotEmpty) queryParameters['dateFrom'] = dateFrom;
    if (dateTo != null && dateTo.isNotEmpty) queryParameters['dateTo'] = dateTo;

    final response = await apiConsumer.get(
      ApiConstants.analytics,
      queryParameters: queryParameters,
    );

    // الباكيند باعت الداتا جوه كائن 'data' مجمع ومحسن
    return FullAnalyticsModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}