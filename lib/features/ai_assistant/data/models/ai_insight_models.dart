import '../../domain/entities/ai_insight_entities.dart';

class AiInsightModel extends AiInsightEntity {
  const AiInsightModel({
    required super.id,
    required super.templateId,
    required super.category,
    required super.title,
    required super.message,
    required super.isSeen,
    required super.metadata,
    required super.createdAt,
  });

  factory AiInsightModel.fromJson(Map<String, dynamic> json) {
    return AiInsightModel(
      id: json['id'] ?? '',
      templateId: json['templateId'] ?? '',
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      isSeen: json['isSeen'] ?? false,
      metadata: json['metadata'] ?? {},
      createdAt: json['createdAt'] ?? '',
    );
  }
}

class AiInsightResponseModel extends AiInsightResponse {
  const AiInsightResponseModel({
    required super.items,
    required super.total,
    required super.page,
    required super.limit,
  });

  factory AiInsightResponseModel.fromJson(Map<String, dynamic> json) {
    return AiInsightResponseModel(
      items: (json['items'] as List?)?.map((e) => AiInsightModel.fromJson(e)).toList() ?? [],
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
    );
  }
}