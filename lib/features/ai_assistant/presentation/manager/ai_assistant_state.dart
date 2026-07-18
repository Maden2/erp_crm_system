import '../../domain/entities/ai_insight_entities.dart';

abstract class AiAssistantState {}

class AiAssistantInitial extends AiAssistantState {}

// ================== GET INSIGHTS STATES ==================
class GetAiInsightsLoading extends AiAssistantState {}
class GetAiInsightsSuccess extends AiAssistantState {
  final AiInsightResponse response;
  GetAiInsightsSuccess(this.response);
}
class GetAiInsightsError extends AiAssistantState {
  final String message;
  GetAiInsightsError(this.message);
}

// ================== GENERATE FRESH INSIGHTS STATES ==================
class GenerateAiInsightsLoading extends AiAssistantState {}
class GenerateAiInsightsSuccess extends AiAssistantState {
  final List<AiInsightEntity> insights;
  GenerateAiInsightsSuccess(this.insights);
}
class GenerateAiInsightsError extends AiAssistantState {
  final String message;
  GenerateAiInsightsError(this.message);
}

// ================== ADMIN FEEDBACK STATES (ENDPOINT 5) ==================
class GetAdminFeedbackLoading extends AiAssistantState {}
class GetAdminFeedbackSuccess extends AiAssistantState {
  final Map<String, dynamic> feedbackData;
  GetAdminFeedbackSuccess(this.feedbackData);
}
class GetAdminFeedbackError extends AiAssistantState {
  final String message;
  GetAdminFeedbackError(this.message);
}

// ================== COMMON ACTIONS (SEEN / SUBMIT FEEDBACK) ==================
class AiActionSuccess extends AiAssistantState {}