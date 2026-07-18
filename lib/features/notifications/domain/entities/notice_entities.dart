import 'package:equatable/equatable.dart';

class NoticeItemEntity extends Equatable {
  final String id;
  final String type;
  final String title;
  final String body;
  final bool isRead;
  final String createdAt;

  const NoticeItemEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, type, title, body, isRead, createdAt];
}

class NoticeMetaEntity extends Equatable {
  final int total;
  final int unreadCount;

  const NoticeMetaEntity({
    required this.total,
    required this.unreadCount,
  });

  @override
  List<Object?> get props => [total, unreadCount];
}