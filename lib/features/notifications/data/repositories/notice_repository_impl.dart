import '../../domain/repositories/notice_repository.dart';
import '../datasources/notice_remote_data_source.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeRemoteDataSource remoteDataSource;

  NoticeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Map<String, dynamic>> getNotices({bool? isRead}) async {
    return await remoteDataSource.getNotices(isRead: isRead);
  }

  @override
  Future<void> markAllAsRead() async {
    await remoteDataSource.markAllAsRead();
  }

  @override
  Future<void> markAsRead(String id) async {
    await remoteDataSource.markAsRead(id);
  }

  @override
  Future<void> clearAllNotices() async {
    await remoteDataSource.clearAllNotices();
  }

  @override
  Future<void> deleteNotice(String id) async {
    await remoteDataSource.deleteNotice(id);
  }
}