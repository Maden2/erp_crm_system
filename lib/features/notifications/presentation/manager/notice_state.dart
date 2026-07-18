import '../../domain/entities/notice_entities.dart';

abstract class NoticeState {}

class NoticeInitial extends NoticeState {}
class NoticeLoading extends NoticeState {}
class NoticeActionLoading extends NoticeState {} // للعمليات السريعة زي حذف أو قراءة إشعار مفرد

class NoticeSuccess extends NoticeState {
  final List<NoticeItemEntity> notices;
  final NoticeMetaEntity meta;
  final String? message;

  NoticeSuccess({
    required this.notices,
    required this.meta,
    this.message,
  });
}

class NoticeError extends NoticeState {
  final String message;
  NoticeError(this.message);
}