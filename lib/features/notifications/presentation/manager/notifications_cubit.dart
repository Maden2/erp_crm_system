import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/notification_model.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  void fetchNotifications() {
    emit(NotificationsLoading());

    // محاكاة سريعة للموك داتا
    Future.delayed(const Duration(milliseconds: 250), () {
      emit(NotificationsSuccess(MockNotificationData.mockNotifications));
    });
  }
}