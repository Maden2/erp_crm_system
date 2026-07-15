class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final String createdAt;
  final String type; // new_order, low_stock, info, sales, system
  final bool isRead;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.type,
    required this.isRead,
  });
}