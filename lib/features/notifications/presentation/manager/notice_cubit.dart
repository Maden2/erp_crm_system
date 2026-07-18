import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/notice_usecases.dart';
import 'notice_state.dart';

class NoticeCubit extends Cubit<NoticeState> {
  final GetNoticesUseCase getNoticesUseCase;
  final MarkAllNoticesReadUseCase markAllNoticesReadUseCase;
  final MarkNoticeAsReadUseCase markNoticeAsReadUseCase;
  final ClearAllNoticesUseCase clearAllNoticesUseCase;

  NoticeCubit({
    required this.getNoticesUseCase,
    required this.markAllNoticesReadUseCase,
    required this.markNoticeAsReadUseCase,
    required this.clearAllNoticesUseCase,
  }) : super(NoticeInitial());

  bool? _currentFilter; // حفظ الفلتر الحالي (null = الكل، false = غير المقروء)

  // 1. جلب الإشعارات (الكل أو غير المقروء بس)
  Future<void> fetchNotices({bool? isRead}) async {
    _currentFilter = isRead;
    emit(NoticeLoading());
    try {
      final result = await getNoticesUseCase(isRead: isRead);
      emit(NoticeSuccess(
        notices: result['items'],
        meta: result['meta'],
      ));
    } catch (e) {
      emit(NoticeError(e.toString()));
    }
  }

  // 2. تحديد إشعار واحد كمقروء (عند الضغط عليه)
  Future<void> markAsRead(String id) async {
    try {
      await markNoticeAsReadUseCase(id);
      // إعادة جلب الداتا بالفلتر الحالي لتحديث الـ Badge والـ Blue Dot فوراً
      final result = await getNoticesUseCase(isRead: _currentFilter);
      emit(NoticeSuccess(
        notices: result['items'],
        meta: result['meta'],
      ));
    } catch (e) {
      emit(NoticeError(e.toString()));
    }
  }

  // 3. تحديد الكل كمقروء (الزرار اللي فوق في الـ UI)
  Future<void> markAllAsRead() async {
    emit(NoticeActionLoading());
    try {
      await markAllNoticesReadUseCase();
      final result = await getNoticesUseCase(isRead: _currentFilter);
      emit(NoticeSuccess(
        notices: result['items'],
        meta: result['meta'],
        message: "تم تحديد جميع الإشعارات كمقروءة",
      ));
    } catch (e) {
      emit(NoticeError(e.toString()));
    }
  }

  // 4. مسح وحذف كل الإشعارات
  Future<void> clearAll() async {
    emit(NoticeLoading());
    try {
      await clearAllNoticesUseCase();
      final result = await getNoticesUseCase(isRead: _currentFilter);
      emit(NoticeSuccess(
        notices: result['items'],
        meta: result['meta'],
      ));
    } catch (e) {
      emit(NoticeError(e.toString()));
    }
  }
}