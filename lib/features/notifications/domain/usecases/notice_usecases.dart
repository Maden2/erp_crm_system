import '../repositories/notice_repository.dart';

class GetNoticesUseCase {
  final NoticeRepository repository;
  GetNoticesUseCase(this.repository);

  Future<Map<String, dynamic>> call({bool? isRead}) async {
    return await repository.getNotices(isRead: isRead);
  }
}

class MarkAllNoticesReadUseCase {
  final NoticeRepository repository;
  MarkAllNoticesReadUseCase(this.repository);

  Future<void> call() async {
    await repository.markAllAsRead();
  }
}

class MarkNoticeAsReadUseCase {
  final NoticeRepository repository;
  MarkNoticeAsReadUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.markAsRead(id);
  }
}

class ClearAllNoticesUseCase {
  final NoticeRepository repository;
  ClearAllNoticesUseCase(this.repository);

  Future<void> call() async {
    await repository.clearAllNotices();
  }
}