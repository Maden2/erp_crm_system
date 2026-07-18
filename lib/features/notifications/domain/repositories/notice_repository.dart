import '../entities/notice_entities.dart';

abstract class NoticeRepository {
  Future<Map<String, dynamic>> getNotices({bool? isRead});
  Future<void> markAllAsRead();
  Future<void> markAsRead(String id);
  Future<void> clearAllNotices();
  Future<void> deleteNotice(String id);
}