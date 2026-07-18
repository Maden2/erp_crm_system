class AiInsightEntity {
  final String id;
  final String templateId;
  final String category;
  final String title;
  final String message;
  final bool isSeen;
  final Map<String, dynamic> metadata;
  final String createdAt;

  const AiInsightEntity({
    required this.id,
    required this.templateId,
    required this.category,
    required this.title,
    required this.message,
    required this.isSeen,
    required this.metadata,
    required this.createdAt,
  });
}

class AiInsightResponse {
  final List<AiInsightEntity> items;
  final int total;
  final int page;
  final int limit;

  const AiInsightResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
  });
}