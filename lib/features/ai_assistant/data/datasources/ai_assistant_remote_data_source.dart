import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/api_constants.dart';
import '../models/ai_insight_models.dart';

abstract class AiAssistantRemoteDataSource {
  Future<AiInsightResponseModel> getAiInsights(int page, int limit, bool unseenOnly);
  Future<List<AiInsightModel>> generateFreshInsights();
  Future<void> markInsightAsSeen(String id);
  Future<void> submitFeedback(Map<String, dynamic> body);
  // 🟢 الميثود الخامس والأخير لـ جلب تقييمات العملاء (Admin) بالملي
  Future<Map<String, dynamic>> getAdminFeedback({required int page, required int limit});
}

class AiAssistantRemoteDataSourceImpl implements AiAssistantRemoteDataSource {
  final ApiConsumer apiConsumer;
  AiAssistantRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<AiInsightResponseModel> getAiInsights(int page, int limit, bool unseenOnly) async {
    final response = await apiConsumer.get(
      ApiConstants.aiInsights,
      queryParameters: {'page': page, 'limit': limit, 'unseenOnly': unseenOnly},
    );
    return AiInsightResponseModel.fromJson(response['data']);
  }

  @override
  Future<List<AiInsightModel>> generateFreshInsights() async {
    final response = await apiConsumer.post(ApiConstants.generateAiInsights);
    final List insightsList = response['data']['insights'] ?? [];
    return insightsList.map((e) => AiInsightModel.fromJson(e)).toList();
  }

  @override
  Future<void> markInsightAsSeen(String id) async {
    await apiConsumer.patch(ApiConstants.markAiInsightSeen(id));
  }

  @override
  Future<void> submitFeedback(Map<String, dynamic> body) async {
    await apiConsumer.post(ApiConstants.aiInsightsFeedback, data: body);
  }

  @override
  Future<Map<String, dynamic>> getAdminFeedback({required int page, required int limit}) async {
    // 🟢 طلقة الـ API الخامسة لجلب تقييمات وتغذية العملاء الـ Admin مسطرة
    final response = await apiConsumer.get(
      ApiConstants.getAdminFeedback,
      queryParameters: {'page': page, 'limit': limit},
    );
    return response['data'] ?? {};
  }
}