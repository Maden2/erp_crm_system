import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/ai_assistant_usecases.dart';
import 'ai_assistant_state.dart';

class AiAssistantCubit extends Cubit<AiAssistantState> {
  final GetAiInsightsUseCase getAiInsightsUseCase;
  final GenerateFreshInsightsUseCase generateFreshInsightsUseCase;
  final MarkInsightAsSeenUseCase markInsightAsSeenUseCase;
  final SubmitAiFeedbackUseCase submitAiFeedbackUseCase;
  final GetAdminFeedbackUseCase getAdminFeedbackUseCase; // 🟢 حقن الـ UseCase الخامسة والأخيرة بالملي

  AiAssistantCubit({
    required this.getAiInsightsUseCase,
    required this.generateFreshInsightsUseCase,
    required this.markInsightAsSeenUseCase,
    required this.submitAiFeedbackUseCase,
    required this.getAdminFeedbackUseCase, // 🟢 مضافة هنا في الـ Constructor
  }) : super(AiAssistantInitial());

  // 1. جلب التوصيات الحالية لليوزر
  Future<void> fetchAiInsights({int page = 1, int limit = 10, bool unseenOnly = false}) async {
    emit(GetAiInsightsLoading());
    final result = await getAiInsightsUseCase(page: page, limit: limit, unseenOnly: unseenOnly);
    result.fold(
          (failure) => emit(GetAiInsightsError(failure.message)),
          (response) => emit(GetAiInsightsSuccess(response)),
    );
  }

  // 2. توليد توصيات جديدة تيربو
  Future<void> triggerFreshInsights() async {
    emit(GenerateAiInsightsLoading());
    final result = await generateFreshInsightsUseCase();
    result.fold(
          (failure) => emit(GenerateAiInsightsError(failure.message)),
          (insights) => emit(GenerateAiInsightsSuccess(insights)),
    );
  }

  // 3. تعيين التوصية كمقروءة
  Future<void> markAsSeen(String id) async {
    final result = await markInsightAsSeenUseCase(id);
    result.fold((_) => null, (_) => emit(AiActionSuccess()));
  }

  // 4. إرسال تقييم وتعليق اليوزر الحالي على توصية معينة
  Future<void> submitInsightFeedback({required String insightId, required int rating, String? comment}) async {
    final result = await submitAiFeedbackUseCase(insightId: insightId, rating: rating, comment: comment);
    result.fold((_) => null, (_) => emit(AiActionSuccess()));
  }

  // 5. جلب كل تقييمات العملاء للإدارة (الـ Endpoint الخامسة والأخيرة لايف)
  Future<void> fetchAdminFeedback({int page = 1, int limit = 20}) async {
    emit(GetAdminFeedbackLoading());
    final result = await getAdminFeedbackUseCase(page: page, limit: limit);
    result.fold(
          (failure) => emit(GetAdminFeedbackError(failure.message)),
          (data) => emit(GetAdminFeedbackSuccess(data)),
    );
  }
}