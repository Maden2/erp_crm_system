import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/ai_insight_entities.dart';

abstract class AiAssistantRepository {
  Future<Either<Failure, AiInsightResponse>> getAiInsights({
    required int page,
    required int limit,
    required bool unseenOnly,
  });

  Future<Either<Failure, List<AiInsightEntity>>> generateFreshInsights();

  Future<Either<Failure, Unit>> markInsightAsSeen(String id);

  Future<Either<Failure, Unit>> submitFeedback({
    required String insightId,
    required int rating,
    String? comment,
  });

  // 🟢 الطرف الخامس والأخير: جلب تقييمات كل العملاء للإدارة بالملي
  Future<Either<Failure, Map<String, dynamic>>> getAdminFeedback({
    required int page,
    required int limit,
  });
}