import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.type,
    required super.title,
    required super.body,
    required super.isRead,
    required super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['Id'] ?? json['id'] ?? '',
      type: json['Type'] ?? json['type'] ?? '',
      title: json['Title'] ?? json['title'] ?? '',
      body: json['Body'] ?? json['body'] ?? '',
      isRead: json['IsRead'] ?? json['isRead'] ?? false,
      createdAt: json['CreatedAt'] ?? json['createdAt'] ?? '',
    );
  }
}