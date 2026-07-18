import '../../../../core/api/api_constants.dart';
import '../../../../core/api/api_consumer.dart';
import '../models/notice_models.dart';

abstract class NoticeRemoteDataSource {
  Future<Map<String, dynamic>> getNotices({bool? isRead});
  Future<void> markAllAsRead();
  Future<void> markAsRead(String id);
  Future<void> clearAllNotices();
  Future<void> deleteNotice(String id);
}

class NoticeRemoteDataSourceImpl implements NoticeRemoteDataSource {
  final ApiConsumer apiConsumer;

  NoticeRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<Map<String, dynamic>> getNotices({bool? isRead}) async {
    final response = await apiConsumer.get(
      ApiConstants.notifications,
      queryParameters: {
        if (isRead != null) 'isRead': isRead,
        'page': 1,
        'limit': 50,
      },
    );

    final List<dynamic> dataList = response['data'] as List? ?? [];
    final items = dataList.map((json) => NoticeItemModel.fromJson(json)).toList();
    final meta = NoticeMetaModel.fromJson(response['meta'] ?? {});

    return {
      'items': items,
      'meta': meta,
    };
  }

  @override
  Future<void> markAllAsRead() async {
    await apiConsumer.patch(ApiConstants.markAllNotificationsRead, data: {});
  }

  @override
  Future<void> markAsRead(String id) async {
    await apiConsumer.patch(ApiConstants.markNotificationAsRead(id), data: {});
  }

  @override
  Future<void> clearAllNotices() async {
    await apiConsumer.delete(ApiConstants.notifications);
  }

  @override
  Future<void> deleteNotice(String id) async {
    await apiConsumer.delete(ApiConstants.deleteNotification(id));
  }
}