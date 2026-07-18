import '../../domain/entities/notice_entities.dart';

class NoticeItemModel extends NoticeItemEntity {
  const NoticeItemModel({
    required super.id,
    required super.type,
    required super.title,
    required super.body,
    required super.isRead,
    required super.createdAt,
  });

  factory NoticeItemModel.fromJson(Map<String, dynamic> json) {
    return NoticeItemModel(
      id: json['Id']?.toString() ?? json['id']?.toString() ?? '',
      type: json['Type']?.toString() ?? json['type']?.toString() ?? 'Unknown',
      title: json['Title']?.toString() ?? json['title']?.toString() ?? '',
      body: json['Body']?.toString() ?? json['body']?.toString() ?? '',
      isRead: json['IsRead'] ?? json['isRead'] ?? false,
      createdAt: json['CreatedAt']?.toString() ?? json['createdAt']?.toString() ?? '',
    );
  }
}

class NoticeMetaModel extends NoticeMetaEntity {
  const NoticeMetaModel({
    required super.total,
    required super.unreadCount,
  });

  factory NoticeMetaModel.fromJson(Map<String, dynamic> json) {
    return NoticeMetaModel(
      total: json['total'] ?? 0,
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}