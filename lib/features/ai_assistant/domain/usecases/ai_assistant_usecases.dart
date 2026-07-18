import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/ai_insight_entities.dart';
import '../repositories/ai_assistant_repository.dart';

class GetAiInsightsUseCase {
  final AiAssistantRepository repository;
  GetAiInsightsUseCase(this.repository);

  Future<Either<Failure, AiInsightResponse>> call({
    int page = 1,
    int limit = 10,
    bool unseenOnly = false,
  }) async {
    return await repository.getAiInsights(page: page, limit: limit, unseenOnly: unseenOnly);
  }
}

class GenerateFreshInsightsUseCase {
  final AiAssistantRepository repository;
  GenerateFreshInsightsUseCase(this.repository);

  Future<Either<Failure, List<AiInsightEntity>>> call() async {
    return await repository.generateFreshInsights();
  }
}

class MarkInsightAsSeenUseCase {
  final AiAssistantRepository repository;
  MarkInsightAsSeenUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.markInsightAsSeen(id);
  }
}

class SubmitAiFeedbackUseCase {
  final AiAssistantRepository repository;
  SubmitAiFeedbackUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String insightId,
    required int rating,
    String? comment,
  }) async {
    return await repository.submitFeedback(insightId: insightId, rating: rating, comment: comment);
  }
}

// 🟢 الـ Use Case المضافة حديثاً للـ Admin Feedback بالملي
class GetAdminFeedbackUseCase {
  final AiAssistantRepository repository;
  GetAdminFeedbackUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call({
    int page = 1,
    int limit = 20,
  }) async {
    return await repository.getAdminFeedback(page: page, limit: limit);
  }
}